#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# CACHING & MIGRATION
# -----------------------------------------------------------------------------
source "$(dirname "${BASH_SOURCE[0]}")/../../caching.sh"
qs_ensure_cache "weather"

# Force standard C locale for number formatting and date parsing (fixes printf and date command issues on varying OS locales)
export LC_ALL=C

# Paths
cache_dir="$QS_CACHE_WEATHER"
json_file="${cache_dir}/weather.json"
view_file="${cache_dir}/view_id"
geo_file="${cache_dir}/location.json"
ENV_FILE="$(dirname "$0")/.env"

# API Settings
# Load environment variables silently
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
fi

# Location is read separately from the bulk export above, since a city name may
# contain spaces which `xargs` would split into separate variables.
read_env() {
    sed -n "s/^$1=//p" "$ENV_FILE" 2>/dev/null | tail -n1 | sed -e "s/^['\"]//" -e "s/['\"]$//"
}

LAT="$(read_env WEATHER_LAT)"
LON="$(read_env WEATHER_LON)"
CITY="$(read_env WEATHER_CITY)"

UNIT="${OPENWEATHER_UNIT:-metric}" # Default to metric if not set

# Determine temperature symbol and the units Open-Meteo should answer in.
# Open-Meteo has no Kelvin, so "standard" is fetched as Celsius and offset.
TEMP_OFFSET=0
case "$UNIT" in
    "imperial") UNIT_SYM="°F"; OM_TEMP="fahrenheit"; OM_WIND="mph" ;;
    "standard") UNIT_SYM="K";  OM_TEMP="celsius";    OM_WIND="ms"; TEMP_OFFSET=273.15 ;;
    *)          UNIT_SYM="°C"; OM_TEMP="celsius";    OM_WIND="ms" ;;
esac

mkdir -p "${cache_dir}"

get_icon() {
    case $1 in
        "50d"|"50n") icon="󰖑"; quote="Mist" ;;
        "01d") icon=""; quote="Sunny" ;;
        "01n") icon=""; quote="Clear" ;;
        "02d"|"02n"|"03d"|"03n"|"04d"|"04n") icon=""; quote="Cloudy" ;;
        "09d"|"09n"|"10d"|"10n") icon="󰖗"; quote="Rainy" ;;
        "11d"|"11n") icon=""; quote="Storm" ;;
        "13d"|"13n") icon=""; quote="Snow" ;;
        *) icon=""; quote="Unknown" ;;
    esac
    echo "$icon|$quote"
}

get_hex() {
    case $1 in
        "50d"|"50n") echo "#84afdb" ;;
        "01d") echo "#f9e2af" ;;
        "01n") echo "#cba6f7" ;;
        "02d"|"02n"|"03d"|"03n"|"04d"|"04n") echo "#bac2de" ;;
        "09d"|"09n"|"10d"|"10n") echo "#74c7ec" ;;
        "11d"|"11n") echo "#f9e2af" ;;
        "13d"|"13n") echo "#cdd6f4" ;;
        *) echo "#cdd6f4" ;;
    esac
}

# Glyph/colour lookup table, built from the two functions above so they stay the
# single source of truth. jq maps WMO codes onto these condition keys.
build_lut() {
    local out="{" c ic hx
    for c in 01d 01n 02d 02n 03d 03n 04d 04n 09d 09n 10d 10n 11d 11n 13d 13n 50d 50n; do
        ic=$(get_icon "$c" | cut -d'|' -f1)
        hx=$(get_hex "$c")
        out+="\"$c\":{\"icon\":\"$ic\",\"hex\":\"$hx\"},"
    done
    echo "${out%,}}"
}

write_dummy_data() {
    final_json="["
    for i in {0..4}; do
        future_date=$(date -d "+$i days")
        f_day=$(date -d "$future_date" "+%a")
        f_full_day=$(date -d "$future_date" "+%A")
        f_date_num=$(date -d "$future_date" "+%d %b")
        
        final_json="${final_json} {
            \"id\": \"${i}\",
            \"day\": \"${f_day}\",
            \"day_full\": \"${f_full_day}\",
            \"date\": \"${f_date_num}\",
            \"max\": \"0.0\",
            \"min\": \"0.0\",
            \"feels_like\": \"0.0\",
            \"wind\": \"0\",
            \"humidity\": \"0\",
            \"pop\": \"0\",
            \"icon\": \"\",
            \"hex\": \"#cdd6f4\",
            \"desc\": \"Offline\",
            \"hourly\": [{\"time\": \"00:00\", \"temp\": \"0.0\", \"icon\": \"\", \"hex\": \"#cdd6f4\"}]
        },"
    done
    final_json="${final_json%,}]"
    echo "{ \"current_temp\": \"0.0\", \"current_icon\": \"\", \"current_hex\": \"#cdd6f4\", \"forecast\": ${final_json} }" > "${json_file}"
}

# Resolve WEATHER_CITY -> coordinates via Open-Meteo's geocoder (also key-free).
# Cached, so the lookup happens once per city rather than on every refresh.
resolve_location() {
    # Explicit coordinates always win
    if [[ -n "$LAT" && -n "$LON" ]]; then return 0; fi

    if [ -z "$CITY" ]; then
        # Ankara
        LAT="39.9199"; LON="32.8543"
        return 0
    fi

    if [ -f "$geo_file" ] && [[ "$(jq -r '.city // empty' "$geo_file")" == "$CITY" ]]; then
        LAT=$(jq -r '.lat' "$geo_file")
        LON=$(jq -r '.lon' "$geo_file")
        return 0
    fi

    local geo
    geo=$(curl -sf --get "https://geocoding-api.open-meteo.com/v1/search" \
        --data-urlencode "name=$CITY" --data-urlencode "count=1")

    local glat glon
    glat=$(echo "$geo" | jq -r '.results[0].latitude // empty' 2>/dev/null)
    glon=$(echo "$geo" | jq -r '.results[0].longitude // empty' 2>/dev/null)

    if [[ -n "$glat" && -n "$glon" ]]; then
        LAT="$glat"; LON="$glon"
        jq -n --arg c "$CITY" --arg la "$glat" --arg lo "$glon" \
            '{city: $c, lat: $la, lon: $lo}' > "$geo_file"
    else
        # Geocoding failed (offline / unknown city) — fall back to Ankara
        LAT="39.9199"; LON="32.8543"
    fi
}

get_data() {
    resolve_location

    raw=$(curl -sf --get "https://api.open-meteo.com/v1/forecast" \
        -d "latitude=$LAT" \
        -d "longitude=$LON" \
        -d "current=temperature_2m,weather_code,is_day" \
        -d "hourly=temperature_2m,weather_code,is_day,relative_humidity_2m" \
        -d "daily=weather_code,temperature_2m_max,temperature_2m_min,apparent_temperature_max,precipitation_probability_max,wind_speed_10m_max" \
        -d "temperature_unit=$OM_TEMP" \
        -d "wind_speed_unit=$OM_WIND" \
        -d "timezone=auto" \
        -d "forecast_days=5")

    # Bail out without destroying a working cache if the request failed or the
    # payload is not what we expect. Only write dummy data if there is no cache.
    if [ -z "$raw" ] || [[ "$(echo "$raw" | jq -r '.daily.time | length' 2>/dev/null)" != "5" ]]; then
        if [ ! -f "$json_file" ]; then
            write_dummy_data
        fi
        return
    fi

    built=$(echo "$raw" | jq -c --argjson lut "$(build_lut)" --argjson off "$TEMP_OFFSET" '
        # One decimal place, matching the previous printf "%.1f" output
        def f1: (. * 10 | round) / 10 | tostring | if test("\\.") then . else . + ".0" end;

        # WMO weather code -> the OpenWeather-style condition key the icon
        # and colour tables are written against
        def cond(c; d):
          (if d == 1 then "d" else "n" end) as $s
          | (if   c <= 1                then "01"
             elif c == 2                then "02"
             elif c == 3                then "04"
             elif c == 45 or c == 48    then "50"
             elif c >= 51 and c <= 57   then "09"
             elif c >= 61 and c <= 67   then "10"
             elif c >= 71 and c <= 77   then "13"
             elif c >= 80 and c <= 82   then "09"
             elif c == 85 or c == 86    then "13"
             elif c >= 95               then "11"
             else "01" end) + $s;

        def desc(c):
          if   c == 0  then "Clear Sky"      elif c == 1  then "Mainly Clear"
          elif c == 2  then "Partly Cloudy"  elif c == 3  then "Overcast"
          elif c == 45 then "Fog"            elif c == 48 then "Rime Fog"
          elif c == 51 then "Light Drizzle"  elif c == 53 then "Drizzle"
          elif c == 55 then "Heavy Drizzle"  elif c == 56 or c == 57 then "Freezing Drizzle"
          elif c == 61 then "Light Rain"     elif c == 63 then "Rain"
          elif c == 65 then "Heavy Rain"     elif c == 66 or c == 67 then "Freezing Rain"
          elif c == 71 then "Light Snow"     elif c == 73 then "Snow"
          elif c == 75 then "Heavy Snow"     elif c == 77 then "Snow Grains"
          elif c == 80 then "Light Showers"  elif c == 81 then "Showers"
          elif c == 82 then "Violent Showers"
          elif c == 85 then "Snow Showers"   elif c == 86 then "Heavy Snow Showers"
          elif c == 95 then "Thunderstorm"   elif c == 96 or c == 99 then "Thunderstorm With Hail"
          else "Unknown" end;

        . as $r
        | [range(0; $r.hourly.time | length) | {
            t:    $r.hourly.time[.],
            temp: $r.hourly.temperature_2m[.],
            code: $r.hourly.weather_code[.],
            day:  $r.hourly.is_day[.],
            hum:  $r.hourly.relative_humidity_2m[.]
          }] as $hr
        | cond($r.current.weather_code; $r.current.is_day) as $cc
        | {
            current_temp: (($r.current.temperature_2m + $off) | f1),
            current_icon: $lut[$cc].icon,
            current_hex:  $lut[$cc].hex,
            forecast: [
              range(0; $r.daily.time | length) as $i
              | $r.daily.time[$i] as $d
              | ($hr | map(select(.t | startswith($d)))) as $dh
              | $r.daily.weather_code[$i] as $dc
              | cond($dc; 1) as $di
              | {
                  id:         ($i | tostring),
                  day:        ($d + "T00:00:00Z" | fromdate | strftime("%a")),
                  day_full:   ($d + "T00:00:00Z" | fromdate | strftime("%A")),
                  date:       ($d + "T00:00:00Z" | fromdate | strftime("%d %b")),
                  max:        (($r.daily.temperature_2m_max[$i] + $off) | f1),
                  min:        (($r.daily.temperature_2m_min[$i] + $off) | f1),
                  feels_like: (($r.daily.apparent_temperature_max[$i] + $off) | f1),
                  wind:       (($r.daily.wind_speed_10m_max[$i] // 0) | round | tostring),
                  humidity:   (if ($dh | length) > 0
                               then (($dh | map(.hum) | add) / ($dh | length) | round)
                               else 0 end | tostring),
                  pop:        (($r.daily.precipitation_probability_max[$i] // 0) | tostring),
                  icon:       $lut[$di].icon,
                  hex:        $lut[$di].hex,
                  desc:       desc($dc),
                  # Every third hour, so each day yields the 8 slots the UI slices
                  hourly: [
                    $dh[]
                    | select((.t[11:13] | tonumber) % 3 == 0)
                    | cond(.code; .day) as $ic
                    | { time: .t[11:16],
                        temp: ((.temp + $off) | f1),
                        icon: $lut[$ic].icon,
                        hex:  $lut[$ic].hex }
                  ]
                }
            ]
          }
    ' 2>/dev/null)

    # Only replace the cache once jq has produced something valid
    if [ -n "$built" ]; then
        echo "$built" > "${json_file}.tmp" && mv "${json_file}.tmp" "${json_file}"
    elif [ ! -f "$json_file" ]; then
        write_dummy_data
    fi
}

# --- MODE HANDLING ---
if [[ "$1" == "--getdata" ]]; then
    get_data

elif [[ "$1" == "--json" ]]; then
    CACHE_LIMIT=900          # 15 minutes for valid working data
    OFFLINE_RETRY_LIMIT=300  # 5 minutes when the last fetch failed

    if [ -f "$json_file" ]; then
        file_time=$(stat -c %Y "$json_file")
        current_time=$(date +%s)
        diff=$((current_time - file_time))

        if grep -q '"desc": "Offline"' "$json_file"; then
            # Last fetch failed. Retry more eagerly than the normal refresh.
            if [ $diff -gt $OFFLINE_RETRY_LIMIT ]; then
                touch "$json_file" # Bump file timestamp slightly to avoid spamming processes
                get_data &
            fi
        else
            # Normal working cache. Check every 15 mins.
            if [ $diff -gt $CACHE_LIMIT ]; then
                touch "$json_file"
                get_data &
            fi
        fi
        cat "$json_file"
    else
        get_data
        cat "$json_file"
    fi

elif [[ "$1" == "--view-listener" ]]; then
    if [ ! -f "$view_file" ]; then echo "0" > "$view_file"; fi
    tail -F "$view_file"

elif [[ "$1" == "--nav" ]]; then
    if [ ! -f "$view_file" ]; then echo "0" > "$view_file"; fi
    current=$(cat "$view_file")
    direction=$2
    max_idx=4
    if [[ "$direction" == "next" ]]; then
        if [ "$current" -lt "$max_idx" ]; then
            new=$((current + 1))
            echo "$new" > "$view_file"
        fi
    elif [[ "$direction" == "prev" ]]; then
        if [ "$current" -gt 0 ]; then
            new=$((current - 1))
            echo "$new" > "$view_file"
        fi
    fi

elif [[ "$1" == "--icon" ]]; then
    cat "$json_file" | jq -r '.forecast[0].icon'

elif [[ "$1" == "--temp" ]]; then
    t=$(cat "$json_file" | jq -r '.forecast[0].max')
    echo "${t}${UNIT_SYM}"

elif [[ "$1" == "--hex" ]]; then
    cat "$json_file" | jq -r '.forecast[0].hex'

elif [[ "$1" == "--current-icon" ]]; then
    icon=$(cat "$json_file" | jq -r '.current_icon // empty')
    if [[ -z "$icon" || "$icon" == "null" ]]; then
        get_data
        icon=$(cat "$json_file" | jq -r '.current_icon')
    fi
    echo "$icon"

elif [[ "$1" == "--current-temp" ]]; then
    t=$(cat "$json_file" | jq -r '.current_temp // empty')
    if [[ -z "$t" || "$t" == "null" ]]; then
        get_data
        t=$(cat "$json_file" | jq -r '.current_temp')
    fi
    echo "${t}${UNIT_SYM}"

elif [[ "$1" == "--current-hex" ]]; then
    hex=$(cat "$json_file" | jq -r '.current_hex // empty')
    if [[ -z "$hex" || "$hex" == "null" ]]; then
        get_data
        hex=$(cat "$json_file" | jq -r '.current_hex')
    fi
    echo "$hex"
fi
