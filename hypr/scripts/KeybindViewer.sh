#!/bin/bash
# Parse hyprctl binds and display in rofi for quick reference

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
  exit 0
fi

hyprctl binds -j | jq -r '
  .[] |
  select(.description | length > 0) |
  # Decode modmask bitmask to modifier names
  (
    [ if .modmask % 2 >= 1 then "SHIFT" else empty end,
      if (.modmask / 2 | floor) % 2 >= 1 then "CAPS" else empty end,
      if (.modmask / 4 | floor) % 2 >= 1 then "CTRL" else empty end,
      if (.modmask / 8 | floor) % 2 >= 1 then "ALT" else empty end,
      if (.modmask / 64 | floor) % 2 >= 1 then "SUPER" else empty end
    ] | join(" + ")
  ) as $mods |
  if ($mods | length) > 0 then
    "\(.description)\t\($mods) + \(.key)"
  else
    "\(.description)\t\(.key)"
  end
' | column -t -s $'\t' | sort | rofi -dmenu -i -p "Keybindings" -theme-str 'window {width: 60%;}'
