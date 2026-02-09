# Omarchy-Inspired Improvements — Changelog

**Date:** 2025-02-09
**Source:** PRP/OMARCHY_IMPROVEMENTS.md (Omarchy v3.3.3)

---

## New Scripts (6)

All in `~/.config/hypr/scripts/`, all executable.

| Script | Keybind | Description |
|--------|---------|-------------|
| `WindowPop.sh` | SUPER+O | Float/pin/resize window as overlay; toggle back to tiled |
| `ToggleGaps.sh` | SUPER+SHIFT+BACKSPACE | Toggle gaps on/off per workspace (focus mode) |
| `TerminalCWD.sh` | SUPER+T | New terminal inherits focused terminal's working directory |
| `AudioSwitch.sh` | SUPER+XF86AudioMute | Cycle through audio output sinks via wpctl |
| `CloseAllWindows.sh` | CTRL+ALT+Delete | Close every open window, return to workspace 1 |
| `KeybindViewer.sh` | SUPER+K | Display all described keybinds in rofi |

## Modified Scripts (1)

- **Volume.sh** — Added `--inc1` / `--dec1` flags for 1% fine volume control

## Keybind Overhaul

- Converted ALL `bind` to `bindd` (self-documenting with descriptions) — 54 total
- Split `UserKeybinds.conf` into hub file sourcing `UserConfigs/bindings/`:
  - `apps.conf` — App launchers (rofi, browser, terminal, file manager)
  - `clipboard.conf` — Universal copy/paste/cut + clipboard history
  - `media.conf` — Fine volume (1%), fine brightness (1%), audio output cycling
  - `tiling.conf` — 3 fullscreen modes, floating, WindowPop, gap toggle, opacity toggle, zoom
  - `utilities.conf` — Notifications, waybar, wallpaper, theming, screenshots, close-all, exit

### New Keybinds Added

| Keybind | Action |
|---------|--------|
| SUPER+O | WindowPop (float/pin toggle) |
| SUPER+C / V / X | Universal copy / paste / cut (sendshortcut) |
| SUPER+CTRL+V | Clipboard history (supplements existing SUPER+ALT+V) |
| SUPER+SHIFT+BACKSPACE | Per-workspace gap toggle |
| SUPER+BACKSPACE | Toggle window transparency |
| SUPER+ALT+F | Monocle fullscreen (fullscreenstate 0 2) |
| SUPER+COMMA | Dismiss latest notification |
| SUPER+SHIFT+COMMA | Dismiss all notifications |
| SUPER+CTRL+COMMA | Toggle DND |
| SUPER+ALT+COMMA | Toggle notification panel |
| ALT+VolumeUp/Down | Fine 1% volume |
| ALT+BrightnessUp/Down | Fine 1% brightness |
| SUPER+XF86AudioMute | Cycle audio output |
| SUPER+K | Keybind viewer (rofi) |
| CTRL+ALT+Delete | Close all windows (was: exit Hyprland) |
| SUPER+CTRL+ALT+Delete | Exit Hyprland (moved here) |

### Keybind Conflicts (intentional overrides)

- `SUPER+COMMA` overrides `workspace e-1` from Keybinds.conf — 3 other workspace scroll methods remain
- `SUPER+K` overrides `layoutmsg cycleprev` — only relevant in Master layout (user uses dwindle)
- `CTRL+ALT+Delete` overrides exit Hyprland — moved to `SUPER+CTRL+ALT+Delete`

## Window Rules Overhaul

- Split `WindowRules.conf` into hub file sourcing `UserConfigs/apps/`:
  - `browser.conf` — Firefox, Chrome, Edge, Brave, Zen
  - `terminal.conf` — Alacritty, kitty, wezterm
  - `projects.conf` — VSCode, JetBrains IDEs
  - `jetbrains.conf` — Splash screen, popup, tooltip fixes (new)
  - `im.conf` — Discord, Telegram, WhatsApp, Ferdium
  - `media.conf` — mpv, VLC, Audacious
  - `steam.conf` — Gamescope, Steam, Lutris
  - `filemanager.conf` — Thunar, Nautilus
  - `settings.conf` — pavucontrol, rofi, qt5ct, etc.
  - `viewer.conf` — System monitor, evince, eog
  - `pip.conf` — Picture-in-Picture float/pin/move/keep_aspect_ratio

### Tag-Based Default Opacity

New opt-out pattern for automatic opacity on unknown/untagged apps:
1. All windows tagged `+default-opacity` via `match:class .*`
2. Each app file opts out with `tag -default-opacity` before setting custom opacity
3. Bottom of WindowRules.conf applies `opacity 0.97 0.9` to remaining `match:tag default-opacity`

## Post-Implementation Fixes

### SUPER+D Fullscreen Restored
- `SUPER+D` was changed to `fullscreenstate, 0 2` which only minimized but didn't toggle back
- Restored to `fullscreen, 1` (fake fullscreen — proper toggle)
- `fullscreenstate, 0 2` (monocle) moved to `SUPER+ALT+F`

### Special Workspace Margins Reduced
- `special_scale_factor` changed from `0.8` to `0.95` in `UserSettings.conf`
- The SUPER+U scratchpad now takes up nearly the full screen instead of leaving large margins

### KeybindViewer Modifier Display Fixed
- `hyprctl binds -j` has no `modmask_str` field — only a numeric `modmask` bitmask
- Script now decodes the bitmask (bit 0=SHIFT, 2=CTRL, 3=ALT, 6=SUPER)
- Shows `SUPER + Space` instead of `nullSpace`

### JetBrains Window Rule Syntax Fixed
- `bordersize` -> `border_size`, `stayfocused` -> `stay_focused`, `noinitialfocus` -> `no_initial_focus`, `suppressevent` -> `suppress_event`
- Hyprland 0.53+ uses underscore-separated property names

## Backups

- `UserConfigs/UserKeybinds.conf.bak` — original keybinds
- `UserConfigs/WindowRules.conf.bak` — original window rules

## Files Changed

| File | Action |
|------|--------|
| `scripts/WindowPop.sh` | Created |
| `scripts/ToggleGaps.sh` | Created |
| `scripts/TerminalCWD.sh` | Created |
| `scripts/AudioSwitch.sh` | Created |
| `scripts/CloseAllWindows.sh` | Created |
| `scripts/KeybindViewer.sh` | Created |
| `scripts/Volume.sh` | Modified (added --inc1/--dec1) |
| `UserConfigs/UserKeybinds.conf` | Rewritten as hub |
| `UserConfigs/bindings/*.conf` (5 files) | Created |
| `UserConfigs/WindowRules.conf` | Rewritten as hub |
| `UserConfigs/apps/*.conf` (11 files) | Created |
