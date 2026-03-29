#!/bin/bash
# Launch apps on specific workspaces at login

sleep 2

# Workspace 1: Chrome + Terminal
hyprctl dispatch workspace 1
uwsm-app -- google-chrome-stable &
sleep 1
uwsm-app -- xdg-terminal-exec &
sleep 1

# Workspace 2: Slack + Terminal
hyprctl dispatch workspace 2
uwsm-app -- slack &
sleep 1
uwsm-app -- xdg-terminal-exec &
sleep 1

# Workspace 3: Discord + Spotify + WhatsApp
hyprctl dispatch workspace 3
uwsm-app -- vesktop &
sleep 1
uwsm-app -- spotify &
sleep 1
omarchy-launch-or-focus-webapp WhatsApp "https://web.whatsapp.com/" &
sleep 1

# Go back to workspace 1
hyprctl dispatch workspace 1
