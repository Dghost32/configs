#!/bin/bash
# Cycle through available audio output sinks using wpctl

# Get current default sink ID
current_id=$(wpctl inspect @DEFAULT_AUDIO_SINK@ 2>/dev/null | head -1 | grep -oP 'id \K\d+')

# Get all available sink IDs from wpctl status
mapfile -t sinks < <(wpctl status | awk '/Audio/,/Video/' | awk '/Sinks:/,/Streams:/' | grep -oP '^\s+[\*│├─└]?\s*(\*\s+)?(\d+)\.' | grep -oP '\d+')

if [[ ${#sinks[@]} -lt 2 ]]; then
  notify-send -t 2000 "Audio Output" "Only one output available"
  exit 0
fi

# Find current sink index and cycle to next
for i in "${!sinks[@]}"; do
  if [[ "${sinks[$i]}" == "$current_id" ]]; then
    next_idx=$(( (i + 1) % ${#sinks[@]} ))
    wpctl set-default "${sinks[$next_idx]}"
    next_name=$(wpctl inspect "${sinks[$next_idx]}" 2>/dev/null | grep "node.description" | head -1 | awk -F'"' '{print $2}')
    [[ -z "$next_name" ]] && next_name="Output ${sinks[$next_idx]}"
    notify-send -t 2000 "Audio Output" "$next_name"
    exit 0
  fi
done

# If current not found in list, set first sink
wpctl set-default "${sinks[0]}"
notify-send -t 2000 "Audio Output" "Switched to first available output"
