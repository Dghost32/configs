# WezTerm Config Improvements — Changelog

**Date:** 2026-02-09
**Source:** PRP/WEZTERM_IMPROVEMENTS.md

---

## Bug Fixes

- **Line 58 comment ate keybind**: `-- Resizing` comment swallowed `H` resize-left definition; fixed by separating comment and keybind
- **Duplicate `H` keybind removed**: Line 62 was a duplicate of the eaten line 58

## Theme

- **Catppuccin Mocha enabled**: Was commented out; now matches nvim and Zed editor
- **Status bar**: Shows workspace name in right status (Mauve/`#cba6f7` — Catppuccin accent)

## Rendering

- **`front_end = 'WebGpu'`**: GPU-accelerated rendering for NVIDIA RTX 4060
- **Wayland kept disabled**: `enable_wayland = false` — enabling it caused wezterm to spawn tabs in an invisible instance instead of new windows
- **`use_fancy_tab_bar = false`**: Cleaner retro-style tab bar

## New Keybinds

All existing keybinds preserved. New additions (all use existing `Ctrl+S` leader):

| Keybind | Action |
|---------|--------|
| `Leader + t` | New tab |
| `Leader + w` | Close tab |
| `Leader + n` | Next tab |
| `Leader + p` | Prev tab |
| `Leader + 1-9` | Go to tab N |
| `Leader + /` | Search scrollback |
| `Leader + f` | Increase font size |
| `Leader + d` | Decrease font size |

## Code Cleanup

- Removed stale boilerplate comments
- Organized sections with `-- [[ Section ]]` headers
- Grouped keys by category (clipboard, panes, tabs, search, font, workspaces)
