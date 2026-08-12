#!/usr/bin/env bash
# Alt+Space: pencereyi tiling'den çıkarıp ortada küçük bir kare yapar.
# Geri bastığında tekrar tiling'e döner.
hyprctl dispatch togglefloating
hyprctl activewindow -j | jq -e '.floating' >/dev/null &&
  hyprctl --batch "dispatch resizeactive exact 60% 60% ; dispatch centerwindow"
