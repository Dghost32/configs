# WezTerm Config Improvements — PRP

## Source
- Current config: `terminal/wezterm/.wezterm.lua`
- Reference: nvim + Zed theme consistency (Catppuccin Mocha)
- Hardware: Hyprland (Wayland) + NVIDIA RTX 4060

---

## CURRENT STATE AUDIT

### Issues Found
| Issue | Severity | Details |
|-------|----------|---------|
| Line 58 bug | MEDIUM | `-- Resizing` comment swallowed the first `H` resize keybind |
| Duplicate `H` keybind | LOW | Line 62 duplicates the eaten line 58 definition |
| Color scheme commented out | LOW | Catppuccin Mocha disabled; doesn't match nvim/Zed |
| No tab keybinds | LOW | Can't create or navigate tabs with keyboard |
| No scrollback search | LOW | No way to search terminal output history |
| Wayland disabled | LOW | Running Hyprland but `enable_wayland = false` |
| No GPU acceleration | LOW | No `front_end` setting for NVIDIA RTX 4060 |
| No status bar | LOW | No workspace name display |

### What's Good (Keep)
- Leader key pattern (Ctrl+S) — muscle memory
- Pane split/navigate/resize/zoom
- Workspace create + fuzzy launcher
- JetBrains Mono with ligatures
- 60% opacity transparent background
- Inactive pane dimming
- Auto-reload config

---

## IMPROVEMENTS

### 1. Fix Line 58 Bug
The comment ate a keybind. Fix by separating comment and keybind.

### 2. Enable Catppuccin Mocha
Match nvim and Zed theme.

### 3. Add Tab Management Keybinds
- `Leader + t` — New tab
- `Leader + 1-9` — Go to tab N
- `Leader + n/p` — Next/prev tab
- `Leader + w` — Close tab

### 4. Add Scrollback Search
- `Leader + /` — Search scrollback (like vim `/`)

### 5. Enable WebGpu Frontend
Use GPU acceleration for rendering on NVIDIA RTX 4060.

### 6. Add Status Bar
Show workspace name in the right status area.

### 7. Enable Wayland
Running Hyprland, should use native Wayland.

---

## KEYMAP PRESERVATION

All existing keybinds preserved:
| Binding | Action | Status |
|---------|--------|--------|
| `Ctrl+Shift+V/C` | Paste/Copy | KEEP |
| `Leader + -` | Split horizontal | KEEP |
| `Leader + Shift+_` | Split vertical | KEEP |
| `Leader + h/j/k/l` | Pane navigation | KEEP |
| `Alt + H/J/K/L` | Pane resize | KEEP (fix line 58) |
| `Leader + x` | Close pane | KEEP |
| `Leader + z` | Zoom pane | KEEP |
| `Leader + s` | Workspace fuzzy launcher | KEEP |
| `Leader + c` | Create workspace | KEEP |

### New Keybinds
| Binding | Action |
|---------|--------|
| `Leader + t` | New tab |
| `Leader + 1-9` | Go to tab N |
| `Leader + n` | Next tab |
| `Leader + p` | Prev tab |
| `Leader + w` | Close tab |
| `Leader + /` | Search scrollback |
| `Leader + f` | Font size increase |
| `Leader + d` | Font size decrease |
