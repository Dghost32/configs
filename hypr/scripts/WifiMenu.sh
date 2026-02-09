#!/bin/bash
# Rofi-based WiFi network picker using nmcli
# Shows available networks, connects on selection, prompts for password if needed

notify() { notify-send -t 3000 "WiFi" "$1"; }

# Get current connection
current=$(nmcli -t -f NAME,TYPE connection show --active 2>/dev/null | grep wifi | cut -d: -f1)

# Scan for networks (trigger fresh scan, don't wait)
nmcli device wifi rescan 2>/dev/null &

# List available networks: signal strength + security + name
wifi_list=$(nmcli -t -f SIGNAL,SECURITY,SSID device wifi list 2>/dev/null | \
  grep -v '^$' | \
  sort -t: -k1 -rn | \
  awk -F: '{
    signal = $1
    security = ($2 != "" && $2 != "--") ? " " : ""
    name = $3
    if (name == "") next
    # Mark current connection
    printf "%s%s %s\n", signal "% ", security, name
  }' | \
  uniq -f2)

# Add disconnect/refresh options
if [[ -n "$current" ]]; then
  options="󰤭 Disconnect ($current)\n󰑐 Refresh\n$wifi_list"
else
  options="󰑐 Refresh\n$wifi_list"
fi

# Show rofi
chosen=$(echo -e "$options" | rofi -dmenu -i -p "WiFi" -theme-str 'window {width: 450px;}')
[[ -z "$chosen" ]] && exit 0

# Handle special options
if [[ "$chosen" == *"Disconnect"* ]]; then
  nmcli connection down "$current" && notify "Disconnected from $current"
  exit 0
elif [[ "$chosen" == *"Refresh"* ]]; then
  nmcli device wifi rescan 2>/dev/null
  sleep 1
  exec "$0"
fi

# Extract SSID (remove signal% and lock icon prefix)
ssid=$(echo "$chosen" | sed 's/^[0-9]*% \(  \)\?//')

# Check if we already have a saved connection for this SSID
if nmcli -t -f NAME connection show 2>/dev/null | grep -qx "$ssid"; then
  nmcli connection up "$ssid" 2>/dev/null && notify "Connected to $ssid" || notify "Failed to connect to $ssid"
  exit 0
fi

# Check if network needs a password
if echo "$chosen" | grep -q ""; then
  password=$(rofi -dmenu -p "Password for $ssid" -password -theme-str 'window {width: 450px;}')
  [[ -z "$password" ]] && exit 0
  nmcli device wifi connect "$ssid" password "$password" 2>/dev/null && \
    notify "Connected to $ssid" || notify "Failed to connect to $ssid"
else
  nmcli device wifi connect "$ssid" 2>/dev/null && \
    notify "Connected to $ssid" || notify "Failed to connect to $ssid"
fi
