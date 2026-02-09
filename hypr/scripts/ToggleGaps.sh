#!/bin/bash
# Toggle gaps on/off for the current workspace using workspace rules

workspace_id=$(hyprctl activeworkspace -j | jq -r .id)
state_file="/tmp/hypr-gaps-ws-${workspace_id}"

if [[ -f "$state_file" ]]; then
  # Gaps are off, restore them
  hyprctl keyword "workspace $workspace_id, gapsout:4, gapsin:4, bordersize:1"
  rm "$state_file"
  notify-send -t 1500 "Gaps" "Restored on workspace $workspace_id"
else
  # Gaps are on, remove them
  hyprctl keyword "workspace $workspace_id, gapsout:0, gapsin:0, bordersize:0"
  touch "$state_file"
  notify-send -t 1500 "Focus Mode" "Gaps removed on workspace $workspace_id"
fi
