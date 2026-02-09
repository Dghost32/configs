#!/bin/bash
# Open a new terminal inheriting the CWD of the focused terminal window
# Fast path: single pgrep + readlink, then fallback to plain wezterm

pid=$(hyprctl activewindow -j | jq -r '.pid // empty')
if [[ -n "$pid" ]]; then
  # Find shell child (zsh/bash/fish) in one call
  shell_pid=$(pgrep -a -P "$pid" 2>/dev/null | grep -m1 -oP '^\d+(?=\s+(zsh|bash|fish))')
  # If wezterm/kitty wraps in an intermediate process, check one level deeper
  if [[ -z "$shell_pid" ]]; then
    for child in $(pgrep -P "$pid" 2>/dev/null); do
      shell_pid=$(pgrep -a -P "$child" 2>/dev/null | grep -m1 -oP '^\d+(?=\s+(zsh|bash|fish))')
      [[ -n "$shell_pid" ]] && break
    done
  fi
  if [[ -n "$shell_pid" ]]; then
    cwd=$(readlink /proc/"$shell_pid"/cwd 2>/dev/null)
    [[ -d "$cwd" ]] && exec wezterm start --cwd "$cwd"
  fi
fi

exec wezterm
