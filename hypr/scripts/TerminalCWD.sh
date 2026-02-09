#!/bin/bash
# Open a new terminal inheriting the CWD of the focused terminal window

win_pid=$(hyprctl activewindow -j | jq -r '.pid')
if [[ -n "$win_pid" && "$win_pid" != "null" ]]; then
  # Search up to 2 levels deep for a shell child process
  for depth_pid in $(pgrep -P "$win_pid" 2>/dev/null); do
    shell_pid=$(pgrep -P "$depth_pid" -x "zsh|bash|fish" 2>/dev/null | head -1)
    if [[ -z "$shell_pid" ]]; then
      # Check if the direct child itself is a shell
      comm=$(cat /proc/"$depth_pid"/comm 2>/dev/null)
      if [[ "$comm" =~ ^(zsh|bash|fish)$ ]]; then
        shell_pid="$depth_pid"
      fi
    fi
    if [[ -n "$shell_pid" ]]; then
      cwd=$(readlink /proc/"$shell_pid"/cwd 2>/dev/null)
      if [[ -n "$cwd" && -d "$cwd" ]]; then
        exec wezterm start --cwd "$cwd"
      fi
    fi
  done

  # Also check direct child shells (e.g., kitty spawns shell directly)
  shell_pid=$(pgrep -P "$win_pid" -x "zsh|bash|fish" 2>/dev/null | head -1)
  if [[ -n "$shell_pid" ]]; then
    cwd=$(readlink /proc/"$shell_pid"/cwd 2>/dev/null)
    if [[ -n "$cwd" && -d "$cwd" ]]; then
      exec wezterm start --cwd "$cwd"
    fi
  fi
fi

# Fallback: open plain terminal
exec wezterm
