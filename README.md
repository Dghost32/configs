# Dotfiles

Personal dotfiles for Arch/Manjaro Linux + Hyprland (NVIDIA). Based on [JaKooLit's Hyprland dotfiles](https://github.com/JaKooLit/Hyprland-Dots) with extensive customization.

## What's Included

- **Hyprland** — Tiling WM with waybar, swaync, rofi, swww wallpapers, wallust theming
- **Neovim** — lazy.nvim architecture, native LSP, Catppuccin Mocha theme
- **WezTerm** — GPU-accelerated terminal, Catppuccin Mocha, CTRL+S leader key
- **Zsh** — zinit plugin manager, powerlevel10k, eza aliases
- **Git** — Global config with aliases, LFS, pull rebase
- **Zed** — Vim mode, Catppuccin Mocha, Copilot AI
- **Vim** — Legacy config with CoC

## Installation

```bash
# Clone the repo
git clone https://github.com/Dghost32/configs.git ~/configs
cd ~/configs

# Core install (hyprland, nvim, wezterm, zsh, git, fonts)
./install.sh

# Full install (core + vim, zed, ssh config)
./install-full.sh

# Preview what will happen without making changes
./install.sh --dry-run
```

The installer will:
1. Detect or install an AUR helper (yay/paru)
2. Install all system packages
3. Create symlinks (backs up existing files to `*.bak`)
4. Copy JetBrains Mono Nerd Font to `~/.local/share/fonts/`
5. Set zsh as the default shell

## Symlink Map

### Core (`install.sh`)

| Source | Destination |
|--------|-------------|
| `hypr/` | `~/.config/hypr` |
| `nvim/` | `~/.config/nvim` |
| `terminal/.zshrc` | `~/.zshrc` |
| `terminal/zshrc/` | `~/zshrc` |
| `terminal/wezterm/.wezterm.lua` | `~/.wezterm.lua` |
| `git/.gitconfig` | `~/.gitconfig` |
| `git/.gitignore` | `~/.gitignore` |

### Full adds (`install-full.sh`)

| Source | Destination |
|--------|-------------|
| `vim/.vimrc` | `~/.vimrc` |
| `zed/` | `~/.config/zed` |
| `terminal/ssh/config` | `~/.ssh/config` |

## Manual Setup

If you prefer not to use the install scripts:

```bash
# Example: link just the zsh config
ln -sf ~/configs/terminal/.zshrc ~/.zshrc
ln -sf ~/configs/terminal/zshrc ~/zshrc
```

## Post-Install

1. Log out and back in for zsh to take effect
2. Open WezTerm and let zsh plugins install automatically
3. Open Neovim and let lazy.nvim sync plugins (`:Lazy sync`)
4. Run `hyprctl reload` to load Hyprland config
