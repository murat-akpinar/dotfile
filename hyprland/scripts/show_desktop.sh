#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# SHOW DESKTOP (Windows-style Win+D)
#
# Hyprland has no "minimize", so this sweeps every window on the currently
# visible workspaces into a hidden special workspace. Pressing the bind again
# puts each window back on the workspace it came from and restores focus.
# -----------------------------------------------------------------------------

set -uo pipefail

SPECIAL="special:desktop"
STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/hypr-show-desktop"
STATE_FILE="$STATE_DIR/state"
LOCK_FILE="$STATE_DIR/lock"

mkdir -p "$STATE_DIR"

# Serialize invocations so a double tap can't half-minimize / half-restore
exec 9>"$LOCK_FILE"
flock -n 9 || exit 0

# Hyprland addresses a workspace by id, except named ones (negative id)
ws_target() {
    local id="$1" name="$2"
    if [ "$id" -lt 0 ]; then
        echo "name:$name"
    else
        echo "$id"
    fi
}

restore() {
    local batch="" addr ws focused
    while IFS=$'\t' read -r addr ws; do
        [ -z "$addr" ] && continue
        batch+="dispatch movetoworkspacesilent $ws,address:$addr;"
    done < "$STATE_FILE"

    [ -n "$batch" ] && hyprctl --batch "$batch" >/dev/null

    focused=$(cat "$STATE_DIR/focused" 2>/dev/null)
    [ -n "$focused" ] && hyprctl dispatch focuswindow "address:$focused" >/dev/null

    rm -f "$STATE_FILE" "$STATE_DIR/focused"
}

minimize() {
    local clients monitors visible batch=""

    clients=$(hyprctl clients -j 2>/dev/null) || exit 1
    monitors=$(hyprctl monitors -j 2>/dev/null) || exit 1

    # ids of the workspaces currently shown on each monitor
    visible=$(echo "$monitors" | jq -c '[.[].activeWorkspace.id]')

    # address <TAB> workspace-target, for every non-pinned window on those
    # workspaces (pinned windows follow you everywhere, hiding them is odd)
    local rows
    rows=$(echo "$clients" | jq -r --argjson v "$visible" '
        .[]
        | select(.workspace.id as $id | $v | index($id))
        | select(.pinned | not)
        | "\(.address)\t\(if .workspace.id < 0 then "name:" + .workspace.name else (.workspace.id | tostring) end)"
    ')

    [ -z "$rows" ] && exit 0

    printf '%s\n' "$rows" > "$STATE_FILE"
    hyprctl activewindow -j 2>/dev/null | jq -r '.address // empty' > "$STATE_DIR/focused"

    local addr
    while IFS=$'\t' read -r addr _; do
        [ -z "$addr" ] && continue
        batch+="dispatch movetoworkspacesilent $SPECIAL,address:$addr;"
    done <<< "$rows"

    hyprctl --batch "$batch" >/dev/null
}

if [ -s "$STATE_FILE" ]; then
    restore
else
    minimize
fi
