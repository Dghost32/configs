# Omarchy Customizations

Customizations for a clean [Omarchy](https://omarchy.org/) install. Run on top of a fresh Omarchy system.

## Quick Start

```bash
cd ~/configs/omarchy
./install.sh              # Apply all customizations
./install.sh --dry-run    # Preview without changes
```

After install, run manually:
```bash
chsh -s /usr/bin/zsh      # Switch default shell to zsh
```

Then log out and back in.

## What This Does

### Packages Installed
- **wezterm** — GPU-accelerated terminal (replaces Alacritty as default)
- **zsh** — Shell (replaces bash, with zinit + powerlevel10k + vi-mode)
- **bibata-cursor-theme** — Bibata Modern Ice cursor
- **google-chrome**, **vesktop-bin** (Discord), **spotify-launcher**, **slack-desktop**, **notion-app-electron**
- **pokemon-colorscripts-git** — Pokemon art on terminal startup
- **bluez-utils** — Bluetooth CLI tools

### Hyprland Keybindings (vim-style, migrated from JaKooLit)

| Key | Action | Omarchy Default (overridden) |
|-----|--------|------------------------------|
| `SUPER + T` | Terminal | Toggle float/tiling |
| `SUPER + Q` | Close window | *(free)* |
| `SUPER + SHIFT + Q` | Force kill process | *(free)* |
| `SUPER + E` | File manager (Nautilus) | *(free)* |
| `SUPER + D` | Fake fullscreen | *(free)* |
| `SUPER + Return` | Toggle floating | Terminal |
| `SUPER + H/J/K/L` | Focus left/down/up/right | J=split, K=keybinds, L=layout |
| `SUPER + SHIFT + H/J/K/L` | Resize windows | *(free)* |
| `SUPER + CTRL + H/J/K/L` | Move windows | CTRL+L=lock screen |
| `SUPER + SHIFT + I` | Toggle split direction | *(free)* |
| `SUPER + ,` / `SUPER + .` | Prev/next workspace | Comma=dismiss notification |
| `SUPER + ;` | Dismiss notification | *(free)* |
| `SUPER + U` | Toggle scratchpad | *(free, was SUPER+S)* |
| `SUPER + SHIFT + U` | Move to scratchpad | *(free, was SUPER+ALT+S)* |
| `SUPER + SHIFT + S` | Screenshot area select | *(free)* |
| `SUPER + CTRL + ALT + L` | Lock screen | *(moved from CTRL+L)* |
| `SUPER + CTRL + ALT + K` | Show keybindings | *(moved from K)* |
| `SUPER + W` | Unbound (freed up) | Close window |
| `SUPER + S` | Unbound (for WezTerm leader) | Scratchpad |

### Hyprland Config Changes
- **input.conf** — Caps Lock swapped with Escape (`caps:swapescape`), US layout
- **looknfeel.conf** — 4px rounded window corners
- **envs.conf** — NVIDIA vars + Bibata-Modern-Ice cursor
- **monitors.conf** — 1x scaling for 1080p display (GDK_SCALE=1)
- **autostart.conf** — Runs startup-apps.sh on login

### Startup Apps (startup-apps.sh)
- Workspace 1: Google Chrome + Terminal
- Workspace 2: Slack + Terminal
- Workspace 3: Discord (Vesktop) + Spotify + WhatsApp
- Returns focus to workspace 1

### Waybar
- Clock shows day + date + time (e.g., "Thursday 26 Mar 19:30")
- Transparent background

### Terminal Setup
- **WezTerm** set as default terminal via `xdg-terminals.list`
- Config at `~/configs/terminal/wezterm/.wezterm.lua` (symlinked to `~/.wezterm.lua`)
- Leader key: `SUPER + S` (Command + S on Mac keyboard)
- Font: JetBrainsMono Nerd Font, size 9

### Shell Setup
- **Zsh** with zinit plugin manager
- Plugins: syntax-highlighting, autosuggestions, fzf-tab, powerlevel10k, vi-mode
- Pokemon colorscripts + fastfetch on startup
- Aliases from Omarchy (n, t, d, c, cx, g, ff, eff, open, eza-based ls)
- Config at `~/configs/terminal/.zshrc` + `~/configs/terminal/zshrc/`

### Editor Setup
- **Neovim** — custom lazy.nvim config symlinked from `~/configs/nvim/`
- **Zed** — settings + keymap symlinked from `~/configs/zed/`

### Theme
- Catppuccin with custom anime purple wallpaper
- Bibata Modern Ice cursor (size 24)

### Other Fixes
- `.Xresources` with `Xft.dpi: 96` (fixes XWayland app scaling)
- Chrome desktop file uses chromium icon (Yaru theme fallback fix)
- Vesktop desktop file uses absolute SVG icon path

## File Structure

```
omarchy/
├── install.sh                          # Main installer
├── README.md                           # This file
├── .Xresources                         # X11 DPI fix
├── xdg-terminals.list                  # WezTerm as default terminal
├── hypr/
│   ├── bindings.conf                   # Custom keybindings
│   ├── envs.conf                       # NVIDIA + cursor env vars
│   ├── input.conf                      # Caps/Escape swap
│   ├── looknfeel.conf                  # Rounded corners
│   ├── monitors.conf                   # 1080p 1x scaling
│   ├── autostart.conf                  # Startup script hook
│   └── scripts/
│       └── startup-apps.sh             # App launcher script
├── waybar/
│   ├── config.jsonc                    # Clock format + modules
│   └── style.css                       # Transparent background
└── themes/
    └── catppuccin/
        └── backgrounds/
            └── Anime-Purple-eyes.png   # Custom wallpaper
```

## Dependencies on Other Config Folders

This setup expects these sibling folders in `~/configs/`:
- `terminal/wezterm/.wezterm.lua` — WezTerm config
- `terminal/.zshrc` + `terminal/zshrc/` — Zsh config
- `nvim/` — Neovim config
- `zed/` — Zed editor config

## Notes

- Monitor config assumes 1080p. For 4K, edit `monitors.conf` (uncomment the 1.6 scale section)
- NVIDIA env vars in `envs.conf` are for Turing+ GPUs. Remove if not using NVIDIA
- Startup apps script has sleep delays — adjust if apps launch too slow/fast
- The `SUPER + S` key is freed from Hyprland so WezTerm can use it as leader key
