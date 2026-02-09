#!/bin/bash
# Close all open windows and return to workspace 1

hyprctl clients -j | jq -r ".[].address" | while read -r addr; do
  hyprctl dispatch closewindow "address:$addr"
done

hyprctl dispatch workspace 1
