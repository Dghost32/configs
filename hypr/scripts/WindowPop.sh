#!/bin/bash
# Float, pin, resize, and overlay any window as a quick reference. Toggle back to tiled.

addr=$(hyprctl activewindow -j | jq -r '.address')
tags=$(hyprctl activewindow -j | jq -r '.tags | join(",")')

if echo "$tags" | grep -q "pop"; then
  # Unpop: restore to tiled
  hyprctl -q --batch "dispatch tagwindow -pop; dispatch pin; dispatch togglefloating"
else
  # Pop: float, resize, pin, bring to front
  hyprctl dispatch togglefloating "address:$addr"
  hyprctl dispatch resizeactive exact 1300 900
  hyprctl dispatch centerwindow
  hyprctl -q --batch "dispatch pin; dispatch alterzorder top; dispatch tagwindow +pop"
fi
