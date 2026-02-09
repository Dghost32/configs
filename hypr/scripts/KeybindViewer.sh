#!/bin/bash
# Parse hyprctl binds and display in rofi for quick reference

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
  exit 0
fi

hyprctl binds -j | jq -r '
  .[] |
  select(.description != "" and .description != null) |
  "\(.description)\t\(.modmask_str)\(.key)"
' | column -t -s $'\t' | sort | rofi -dmenu -i -p "Keybindings" -theme-str 'window {width: 60%;}'
