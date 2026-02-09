# Omarchy-Inspired Improvements for JaKooLit Hyprland Config

## Source
- Omarchy repo: https://github.com/basecamp/omarchy (v3.3.3, 19.8k stars)
- Manual: https://learn.omacom.io/2/the-omarchy-manual
- Both setups run Hyprland 0.53+ with new window rule syntax

---

## HIGH-IMPACT FEATURES TO IMPLEMENT

### 1. Window Pop (SUPER+O)
Float, pin, resize, and overlay any window as a quick reference. Toggle back to tiled.

Script (`scripts/WindowPop.sh`):
```bash
#!/bin/bash
addr=$(hyprctl activewindow -j | jq -r '.address')
tags=$(hyprctl activewindow -j | jq -r '.tags | join(",")')

if echo "$tags" | grep -q "pop"; then
  # Unpop: restore to tiled
  hyprctl -q --batch "dispatch pin; dispatch togglefloating; dispatch tagwindow -pop"
else
  # Pop: float, resize, pin, bring to front
  hyprctl dispatch togglefloating "address:$addr"
  hyprctl dispatch resizeactive exact 1300 900
  hyprctl dispatch centerwindow
  hyprctl -q --batch "dispatch pin; dispatch alterzorder top; dispatch tagwindow +pop"
fi
```

Keybind:
```
bindd = SUPER, O, Pop window out (float & pin), exec, $scriptsDir/WindowPop.sh
```

### 2. Universal Copy/Paste
Works identically in terminals AND GUI apps using Ctrl+Insert/Shift+Insert under the hood:
```
bindd = SUPER, C, Universal copy, sendshortcut, CTRL, Insert,
bindd = SUPER, V, Universal paste, sendshortcut, SHIFT, Insert,
bindd = SUPER, X, Universal cut, sendshortcut, CTRL, X,
bindd = SUPER CTRL, V, Clipboard history, exec, $scriptsDir/ClipManager.sh
```

### 3. Terminal Opens in Focused Terminal's CWD
Script (`scripts/TerminalCWD.sh`):
```bash
#!/bin/bash
# Get PID of focused window
win_pid=$(hyprctl activewindow -j | jq -r '.pid')
if [[ -n "$win_pid" && "$win_pid" != "null" ]]; then
  # Find child shell process
  shell_pid=$(pgrep -P "$win_pid" -x "zsh|bash|fish" | head -1)
  if [[ -n "$shell_pid" ]]; then
    cwd=$(readlink /proc/$shell_pid/cwd 2>/dev/null)
    if [[ -n "$cwd" ]]; then
      exec wezterm start --cwd "$cwd"
    fi
  fi
fi
exec wezterm
```

Replace terminal keybind:
```
bindd = SUPER, T, Terminal (inherits CWD), exec, $UserScripts/TerminalCWD.sh
```

### 4. Self-Documenting Keybinds with `bindd`
Replace all `bind =` with `bindd =` (adds description field). Then create a viewer:

Script (`scripts/KeybindViewer.sh`):
```bash
#!/bin/bash
hyprctl binds -j | jq -r '.[] | select(.description != "") | "\(.description)\t\(.modmask_str) + \(.key)"' | \
  column -t -s $'\t' | sort | rofi -dmenu -i -p "Keybindings"
```

Keybind:
```
bindd = SUPER, K, View all keybindings, exec, $scriptsDir/KeybindViewer.sh
```

### 5. Per-Workspace Gap Toggle (Focus Mode)
Script (`scripts/ToggleGaps.sh`):
```bash
#!/bin/bash
workspace_id=$(hyprctl activeworkspace -j | jq -r .id)
gaps=$(hyprctl workspacerules -j | jq -r ".[] | select(.workspaceString==\"$workspace_id\") | .gapsOut[0] // 0")
if [[ "$gaps" == "0" ]]; then
  hyprctl keyword "workspace $workspace_id, gapsout:4, gapsin:4, bordersize:1"
else
  hyprctl keyword "workspace $workspace_id, gapsout:0, gapsin:0, bordersize:0"
fi
```

Keybind:
```
bindd = SUPER SHIFT, BACKSPACE, Toggle workspace gaps, exec, $scriptsDir/ToggleGaps.sh
```

### 6. Precise Media Keys (ALT modifier = 1% steps)
Add to UserKeybinds.conf alongside existing media keys:
```
bindeld = ALT, xf86audioraisevolume, exec, $scriptsDir/Volume.sh --inc1  # 1% volume up
bindeld = ALT, xf86audiolowervolume, exec, $scriptsDir/Volume.sh --dec1  # 1% volume down
bindeld = ALT, xf86MonBrightnessUp, exec, brightnessctl set +1%
bindeld = ALT, xf86MonBrightnessDown, exec, brightnessctl set 1%-
```
(Requires adding --inc1/--dec1 support to Volume.sh or using wpctl directly)

### 7. Audio Output Cycling (SUPER+Mute)
Script (`scripts/AudioSwitch.sh`):
```bash
#!/bin/bash
# Get current default sink
current=$(wpctl inspect @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep "node.name" | awk -F'"' '{print $2}')

# Get all available sinks
sinks=($(wpctl status | awk '/Sinks:/,/Sources:/' | grep -oP '\d+\.' | tr -d '.'))

# Find current index and cycle to next
for i in "${!sinks[@]}"; do
  name=$(wpctl inspect "${sinks[$i]}" 2>/dev/null | grep "node.name" | awk -F'"' '{print $2}')
  if [[ "$name" == "$current" ]]; then
    next_idx=$(( (i + 1) % ${#sinks[@]} ))
    wpctl set-default "${sinks[$next_idx]}"
    next_name=$(wpctl inspect "${sinks[$next_idx]}" 2>/dev/null | grep "node.description" | awk -F'"' '{print $2}')
    notify-send -t 2000 "Audio Output" "$next_name"
    break
  fi
done
```

Keybind:
```
bindld = SUPER, xf86audiomute, Switch audio output, exec, $scriptsDir/AudioSwitch.sh
```

### 8. Three Fullscreen Modes
Currently you have SUPER+F (fullscreen) and SUPER+D (fake fullscreen). Add tiled fullscreen:
```
bindd = SUPER, F, Fullscreen, fullscreen, 0
bindd = SUPER, D, Tiled fullscreen, fullscreenstate, 0 2
bindd = SUPER ALT, F, Full width (monocle), fullscreen, 1
```

### 9. Close All Windows (CTRL+ALT+DELETE override)
Currently CTRL+ALT+DELETE exits Hyprland. Add a close-all option:

Script (`scripts/CloseAllWindows.sh`):
```bash
#!/bin/bash
hyprctl clients -j | jq -r ".[].address" | xargs -I{} hyprctl dispatch closewindow "address:{}"
hyprctl dispatch workspace 1
```

Keybind (replaces or supplements existing CTRL+ALT+Delete):
```
bindd = CTRL ALT, Delete, Close all windows, exec, $scriptsDir/CloseAllWindows.sh
# Keep SUPER+CTRL+ALT+Delete for actual exit:
bindd = SUPER CTRL ALT, Delete, Exit Hyprland, exec, hyprctl dispatch exit 0
```

### 10. Notification Management (SUPER+COMMA)
```
bindd = SUPER, COMMA, Dismiss notification, exec, swaync-client --close-latest
bindd = SUPER SHIFT, COMMA, Dismiss all notifications, exec, swaync-client --close-all
bindd = SUPER CTRL, COMMA, Toggle DND, exec, swaync-client --toggle-dnd
bindd = SUPER ALT, COMMA, Toggle notification panel, exec, swaync-client -t -sw
```
(Replaces current SUPER+SHIFT+N for notification panel toggle)

### 11. Opacity Toggle (SUPER+BACKSPACE)
Quick per-window transparency toggle:
```
bindd = SUPER, BACKSPACE, Toggle window transparency, exec, \
  hyprctl dispatch setprop "address:$(hyprctl activewindow -j | jq -r '.address')" opaque toggle
```

---

## ARCHITECTURE IMPROVEMENTS

### 12. Split Window Rules into Per-App Files
Create `UserConfigs/apps/` directory:
```
UserConfigs/apps/
  browser.conf      # Browser tagging & rules
  terminal.conf     # Terminal tagging & rules
  steam.conf        # Steam/game rules
  jetbrains.conf    # JetBrains IDE fixes
  pip.conf          # Picture-in-Picture rules
  im.conf           # Discord, Telegram, etc.
  media.conf        # mpv, vlc, etc.
  filemanager.conf  # Thunar, Nautilus, etc.
  settings.conf     # Settings apps (pavucontrol, etc.)
```

Then in WindowRules.conf:
```
# Source per-app rules
source = $UserConfigs/apps/browser.conf
source = $UserConfigs/apps/terminal.conf
source = $UserConfigs/apps/steam.conf
# ... etc

# Global rules applied AFTER app-specific ones
windowrule = opacity 0.97 0.9, match:tag default-opacity
```

### 13. Tag-Based Opt-Out Pattern
Tag ALL windows with default-opacity, then apps opt out:
```
# In WindowRules.conf - tag everything
windowrule = tag +default-opacity, match:class .*

# In apps/browser.conf - browsers opt out (they get 1.0 opacity)
windowrule = tag -default-opacity, match:tag browser*

# At the END of WindowRules.conf - apply to remaining
windowrule = opacity 0.97 0.9, match:tag default-opacity
```

### 14. Split Keybinds into Categories
```
UserConfigs/bindings/
  clipboard.conf    # Copy/paste/clipboard history
  media.conf        # Volume, brightness, playerctl
  tiling.conf       # Window management, workspaces, resize, move
  utilities.conf    # Screenshots, menus, toggles, app launchers
```

### 15. JetBrains IDE Fixes (from Omarchy)
These fix common JetBrains issues on Hyprland:
```
# Fix splash screen
windowrule {
    match:class = ^(jetbrains-.*)$
    match:title = ^(splash)$
    match:float = true
    center = on
    no_focus = on
    border_size = 0
}

# Center popups, keep focused for input
windowrule {
    match:class = ^(jetbrains-.*)$
    match:title = ^()$
    match:float = true
    center = on
    stay_focused = on
    border_size = 0
}

# Prevent flicker on autocomplete/tooltips
windowrule {
    match:class = ^(jetbrains-.*)$
    match:title = ^(win.*)$
    match:float = true
    no_initial_focus = on
}

# Disable mouse focus globally for JetBrains
windowrule = no_follow_mouse on, match:class ^(jetbrains-.*)$
```

---

## THEMING COMPARISON

### Your approach (wallust - algorithmic)
- Colors auto-extracted from wallpaper
- Unlimited themes (any wallpaper works)
- Can produce ugly/unreadable color combos
- Mainly covers Hyprland + Waybar

### Omarchy approach (template - curated)
- Single `colors.toml` per theme (18 hand-picked colors)
- `.tpl` template files with `{{ variable }}` substitution
- Generates configs for 14+ apps atomically
- Predictable, always readable, but limited to curated themes

### Hybrid approach (potential improvement)
Keep wallust for color extraction, but add a `colors.toml` override mechanism:
1. Wallust extracts colors from wallpaper -> wallust-hyprland.conf
2. Optional `user-colors.toml` can override specific wallust values
3. Template system generates configs for more apps (rofi, waybar, swaync, etc.)
This gives the best of both worlds.

---

## IMPLEMENTATION PRIORITY

### Phase 1 - Quick Wins (30 min)
- [ ] Window Pop script + keybind
- [ ] Universal copy/paste keybinds
- [ ] Per-workspace gap toggle
- [ ] Opacity toggle (SUPER+BACKSPACE)
- [ ] Three fullscreen modes
- [ ] Notification management keybinds

### Phase 2 - Medium Effort (1-2 hours)
- [ ] Terminal CWD inheritance script
- [ ] Audio output cycling script
- [ ] Close all windows script
- [ ] Precise media keys
- [ ] Convert `bind` to `bindd` throughout
- [ ] Keybinding viewer script

### Phase 3 - Architecture (larger effort)
- [ ] Split WindowRules.conf into per-app files
- [ ] Split keybinds into category files
- [ ] Tag-based opt-out opacity pattern
- [ ] JetBrains IDE window rules
- [ ] Keybinding self-documentation system

### Phase 4 - Theming Enhancement (optional)
- [ ] Template-based theme generation
- [ ] Hybrid wallust + override system
- [ ] Atomic theme switching with full app restart cascade
