#!/bin/bash
# Omarchy customization installer
# Run this AFTER a clean Omarchy install to apply all customizations.
# Usage: ./install.sh [--dry-run]

set -e

DRY_RUN=false
[[ "$1" == "--dry-run" ]] && DRY_RUN=true

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIGS_DIR="$(dirname "$SCRIPT_DIR")"

info() { echo -e "\033[1;34m[INFO]\033[0m $1"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $1"; }
run() {
  if $DRY_RUN; then
    echo "  [DRY-RUN] $1"
  else
    eval "$1"
  fi
}

# ─── AUR Helper ───
if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
  info "Installing yay (AUR helper)..."
  run "cd /tmp && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --noconfirm"
fi
AUR_HELPER=$(command -v yay || command -v paru)

# ─── Packages ───
info "Installing packages..."
PACKAGES=(
  # Terminal & shell
  wezterm zsh
  # Cursor
  bibata-cursor-theme
  # Apps
  google-chrome vesktop-bin spotify-launcher slack-desktop notion-app-electron
  # Fun
  pokemon-colorscripts-git
  # CLI tools (if not already present)
  bluez-utils
)
for pkg in "${PACKAGES[@]}"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    info "  Installing $pkg..."
    run "$AUR_HELPER -S --noconfirm $pkg"
  fi
done

# ─── Hyprland configs ───
info "Copying Hyprland configs..."
for f in bindings.conf looknfeel.conf envs.conf input.conf monitors.conf autostart.conf; do
  run "cp '$SCRIPT_DIR/hypr/$f' ~/.config/hypr/$f"
done

info "Copying startup script..."
run "mkdir -p ~/.config/hypr/scripts"
run "cp '$SCRIPT_DIR/hypr/scripts/startup-apps.sh' ~/.config/hypr/scripts/"
run "chmod +x ~/.config/hypr/scripts/startup-apps.sh"

# ─── Waybar ───
info "Copying Waybar configs..."
run "cp '$SCRIPT_DIR/waybar/config.jsonc' ~/.config/waybar/config.jsonc"
run "cp '$SCRIPT_DIR/waybar/style.css' ~/.config/waybar/style.css"

# ─── Default terminal (WezTerm) ───
info "Setting WezTerm as default terminal..."
run "cp '$SCRIPT_DIR/xdg-terminals.list' ~/.config/xdg-terminals.list"
run "rm -rf ~/.cache/xdg-terminal-exec"

# ─── WezTerm config ───
info "Symlinking WezTerm config..."
if [[ ! -L ~/.wezterm.lua ]]; then
  run "ln -sf '$CONFIGS_DIR/terminal/wezterm/.wezterm.lua' ~/.wezterm.lua"
fi

# ─── Xresources (DPI fix) ───
info "Setting Xresources..."
run "cp '$SCRIPT_DIR/.Xresources' ~/.Xresources"
run "xrdb -merge ~/.Xresources 2>/dev/null || true"

# ─── Neovim config ───
info "Setting up Neovim config..."
if [[ ! -L ~/.config/nvim ]]; then
  if [[ -d ~/.config/nvim ]]; then
    run "mv ~/.config/nvim ~/.config/nvim.omarchy.bak"
  fi
  run "ln -sf '$CONFIGS_DIR/nvim' ~/.config/nvim"
fi

# ─── Zed config ───
info "Setting up Zed config..."
run "mkdir -p ~/.config/zed"
if [[ ! -L ~/.config/zed/settings.json ]]; then
  [[ -f ~/.config/zed/settings.json ]] && run "mv ~/.config/zed/settings.json ~/.config/zed/settings.json.omarchy.bak"
  run "ln -sf '$CONFIGS_DIR/zed/settings.json' ~/.config/zed/settings.json"
fi
if [[ ! -L ~/.config/zed/keymap.json ]]; then
  run "ln -sf '$CONFIGS_DIR/zed/keymap.json' ~/.config/zed/keymap.json"
fi

# ─── Zsh config ───
info "Setting up Zsh..."
if [[ ! -L ~/.zshrc ]]; then
  run "ln -sf '$CONFIGS_DIR/terminal/.zshrc' ~/.zshrc"
fi
if [[ ! -L ~/zshrc ]]; then
  run "ln -sf '$CONFIGS_DIR/terminal/zshrc' ~/zshrc"
fi

# ─── Vi mode in bash (fallback) ───
if ! grep -q "set -o vi" ~/.bashrc 2>/dev/null; then
  info "Adding vi mode to .bashrc..."
  run "echo '' >> ~/.bashrc && echo '# Vi mode' >> ~/.bashrc && echo 'set -o vi' >> ~/.bashrc"
fi

# ─── Theme: Catppuccin with custom wallpaper ───
info "Setting up Catppuccin theme with custom wallpaper..."
if [[ ! -d ~/.config/omarchy/themes/catppuccin ]]; then
  run "cp -r ~/.local/share/omarchy/themes/catppuccin ~/.config/omarchy/themes/catppuccin"
fi
run "cp '$SCRIPT_DIR/themes/catppuccin/backgrounds/Anime-Purple-eyes.png' ~/.config/omarchy/themes/catppuccin/backgrounds/"

# ─── Desktop file overrides (icon fixes) ───
info "Fixing app icons..."
run "mkdir -p ~/.local/share/applications"
if [[ -f /usr/share/applications/google-chrome.desktop ]]; then
  run "cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications/"
  run "sed -i 's/^Icon=google-chrome$/Icon=chromium/' ~/.local/share/applications/google-chrome.desktop"
fi
if [[ -f /usr/share/applications/vesktop.desktop ]]; then
  run "cp /usr/share/applications/vesktop.desktop ~/.local/share/applications/"
  run "sed -i 's|^Icon=vesktop$|Icon=/usr/share/icons/hicolor/scalable/apps/vesktop.svg|' ~/.local/share/applications/vesktop.desktop"
fi

# ─── Apply cursor ───
info "Applying Bibata cursor..."
run "hyprctl setcursor Bibata-Modern-Ice 24 2>/dev/null || true"

# ─── Set theme ───
info "Setting Catppuccin theme..."
run "omarchy-theme-set Catppuccin 2>/dev/null || true"

# ─── Copy wallpaper to active theme ───
info "Adding wallpaper to active theme..."
run "cp '$SCRIPT_DIR/themes/catppuccin/backgrounds/Anime-Purple-eyes.png' ~/.config/omarchy/current/theme/backgrounds/ 2>/dev/null || true"

# ─── Restart services ───
info "Restarting services..."
run "omarchy-restart-waybar 2>/dev/null || true"
run "omarchy-restart-walker 2>/dev/null || true"

# ─── Change default shell ───
info "Setting zsh as default shell..."
if [[ "$SHELL" != */zsh ]]; then
  warn "Run manually: chsh -s /usr/bin/zsh"
fi

echo ""
info "Done! Log out and back in for all changes to take effect."
info "Remember to run 'chsh -s /usr/bin/zsh' if not done already."
