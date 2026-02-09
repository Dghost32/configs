#!/usr/bin/env bash
# ── install.sh ── Core dotfiles bootstrap for Arch + Hyprland ──────────────
# Installs: hyprland, nvim, wezterm, zsh, git, fonts
# Usage:    ./install.sh [--dry-run]
set -euo pipefail

# ── Colors & helpers ───────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false
AUR_HELPER=""

for arg in "$@"; do
    [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
done

header()  { printf "\n${BLUE}${BOLD}══ %s ══${NC}\n" "$1"; }
info()    { printf "${CYAN}  :: %s${NC}\n" "$1"; }
ok()      { printf "${GREEN}  ✓ %s${NC}\n" "$1"; }
warn()    { printf "${YELLOW}  ! %s${NC}\n" "$1"; }
err()     { printf "${RED}  ✗ %s${NC}\n" "$1"; }

dry_run_guard() {
    if $DRY_RUN; then
        info "[dry-run] $*"
        return 1
    fi
    return 0
}

# ── AUR helper detection / install ─────────────────────────────────────────
detect_aur_helper() {
    header "AUR Helper"
    if command -v yay &>/dev/null; then
        AUR_HELPER="yay"
        ok "Found yay"
    elif command -v paru &>/dev/null; then
        AUR_HELPER="paru"
        ok "Found paru"
    else
        warn "No AUR helper found — installing yay"
        if dry_run_guard "Would install yay from AUR"; then
            sudo pacman -S --needed --noconfirm base-devel git
            local tmp
            tmp="$(mktemp -d)"
            git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
            (cd "$tmp/yay-bin" && makepkg -si --noconfirm)
            rm -rf "$tmp"
            AUR_HELPER="yay"
            ok "Installed yay"
        fi
    fi
}

# ── Package installation ──────────────────────────────────────────────────
install_packages() {
    header "System Packages"

    local packages=(
        # Hyprland core
        hyprland waybar swaync rofi-wayland swww wallust hyprlock hypridle
        # Terminal
        wezterm zsh
        # Editor
        neovim
        # CLI tools
        eza jq fzf bat ripgrep zoxide git git-lfs
        fd dust duf sd git-delta tldr
        lazygit yazi
        # Deps
        python nodejs npm
        # Hyprland utilities
        nwg-displays brightnessctl playerctl grim slurp swappy
        wl-clipboard cliphist libnotify polkit-gnome nautilus
        # Fonts
        ttf-jetbrains-mono-nerd
        # Extras
        pokemon-colorscripts-git fastfetch
    )

    info "Installing ${#packages[@]} packages via $AUR_HELPER"

    if dry_run_guard "Would install: ${packages[*]}"; then
        $AUR_HELPER -S --needed --noconfirm "${packages[@]}"
        ok "Packages installed"
    fi
}

# ── Symlink helper ─────────────────────────────────────────────────────────
# create_link <source> <destination>
create_link() {
    local src="$1" dest="$2"

    # Resolve parent dir
    local parent
    parent="$(dirname "$dest")"
    if [[ ! -d "$parent" ]]; then
        if dry_run_guard "Would create directory $parent"; then
            mkdir -p "$parent"
        fi
    fi

    # Already correct symlink?
    if [[ -L "$dest" && "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
        ok "Already linked: $dest"
        return
    fi

    # Backup existing file/dir
    if [[ -e "$dest" || -L "$dest" ]]; then
        if dry_run_guard "Would backup $dest → ${dest}.bak"; then
            mv "$dest" "${dest}.bak"
            warn "Backed up: $dest → ${dest}.bak"
        fi
    fi

    # Create symlink
    if dry_run_guard "Would link $src → $dest"; then
        ln -sf "$src" "$dest"
        ok "Linked: $dest → $src"
    fi
}

# ── Core symlinks ──────────────────────────────────────────────────────────
create_core_symlinks() {
    header "Symlinks (Core)"

    # Hyprland
    create_link "$DOTFILES/hypr" "$HOME/.config/hypr"

    # Neovim
    create_link "$DOTFILES/nvim" "$HOME/.config/nvim"

    # Zsh
    create_link "$DOTFILES/terminal/.zshrc" "$HOME/.zshrc"
    create_link "$DOTFILES/terminal/zshrc"  "$HOME/zshrc"

    # Wezterm
    create_link "$DOTFILES/terminal/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

    # Git
    create_link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
    create_link "$DOTFILES/git/.gitignore" "$HOME/.gitignore"
}

# ── Font installation ─────────────────────────────────────────────────────
install_fonts() {
    header "Fonts"

    local font_dir="$HOME/.local/share/fonts"
    if [[ ! -d "$font_dir" ]]; then
        if dry_run_guard "Would create $font_dir"; then
            mkdir -p "$font_dir"
        fi
    fi

    local count=0
    for f in "$DOTFILES/fonts/"*.ttf; do
        [[ ! -f "$f" ]] && continue
        local name
        name="$(basename "$f")"
        if [[ -f "$font_dir/$name" ]]; then
            count=$((count + 1))
            continue
        fi
        if dry_run_guard "Would copy font: $name"; then
            cp "$f" "$font_dir/"
            count=$((count + 1))
        fi
    done

    if dry_run_guard "Would refresh font cache"; then
        fc-cache -f "$font_dir" 2>/dev/null
    fi

    ok "Installed $count font files"
}

# ── Set zsh as default shell ──────────────────────────────────────────────
set_default_shell() {
    header "Default Shell"

    if [[ "$SHELL" == *"zsh"* ]]; then
        ok "zsh is already the default shell"
        return
    fi

    local zsh_path
    zsh_path="$(command -v zsh)"
    if [[ -z "$zsh_path" ]]; then
        err "zsh not found in PATH"
        return
    fi

    info "Changing default shell to $zsh_path"
    if dry_run_guard "Would run: chsh -s $zsh_path"; then
        chsh -s "$zsh_path"
        ok "Default shell set to zsh (takes effect on next login)"
    fi
}

# ── Post-install notes ────────────────────────────────────────────────────
post_install_notes() {
    header "Done!"

    if $DRY_RUN; then
        warn "This was a dry run — no changes were made."
        echo ""
        return
    fi

    echo ""
    info "Next steps:"
    echo "  1. Log out and back in for zsh to take effect"
    echo "  2. Open wezterm and let zsh plugins install"
    echo "  3. Open nvim and let lazy.nvim sync plugins"
    echo "  4. Run 'hyprctl reload' to load hyprland config"
    echo ""
    info "To install vim, zed, and ssh config too:"
    echo "  ./install-full.sh"
    echo ""
}

# ── Main ──────────────────────────────────────────────────────────────────
main() {
    echo ""
    printf "${BOLD}${CYAN}  Dotfiles Installer (Core)${NC}\n"
    printf "${CYAN}  %s${NC}\n" "$DOTFILES"
    $DRY_RUN && warn "DRY RUN MODE — no changes will be made"
    echo ""

    detect_aur_helper
    install_packages
    create_core_symlinks
    install_fonts
    set_default_shell
    post_install_notes
}

# Allow sourcing without executing (for install-full.sh)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
