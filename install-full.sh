#!/usr/bin/env bash
# ── install-full.sh ── Full dotfiles bootstrap for Arch + Hyprland ─────────
# Installs everything from install.sh + vim, zed, ssh config
# Usage:    ./install-full.sh [--dry-run]
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the core installer (functions + variables, without running main)
source "$DOTFILES/install.sh"

# ── Extra packages ────────────────────────────────────────────────────────
install_extra_packages() {
    header "Extra Packages"

    local packages=(
        vim
        zed-editor
        vesktop-bin
    )

    info "Installing ${#packages[@]} extra packages via $AUR_HELPER"

    if dry_run_guard "Would install: ${packages[*]}"; then
        $AUR_HELPER -S --needed --noconfirm "${packages[@]}"
        ok "Extra packages installed"
    fi
}

# ── Extra symlinks ────────────────────────────────────────────────────────
create_extra_symlinks() {
    header "Symlinks (Extra)"

    # Vim
    create_link "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"

    # Zed
    create_link "$DOTFILES/zed" "$HOME/.config/zed"

    # SSH config
    local ssh_dir="$HOME/.ssh"
    if [[ ! -d "$ssh_dir" ]]; then
        if dry_run_guard "Would create $ssh_dir with mode 700"; then
            mkdir -p "$ssh_dir"
            chmod 700 "$ssh_dir"
        fi
    fi
    create_link "$DOTFILES/terminal/ssh/config" "$HOME/.ssh/config"
}

# ── Post-install notes (full) ────────────────────────────────────────────
post_install_notes_full() {
    header "Done! (Full Install)"

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
    echo "  5. Open zed — settings are already linked"
    echo "  6. Add your SSH keys to ~/.ssh/"
    echo ""
}

# ── Main ──────────────────────────────────────────────────────────────────
main_full() {
    echo ""
    printf "${BOLD}${CYAN}  Dotfiles Installer (Full)${NC}\n"
    printf "${CYAN}  %s${NC}\n" "$DOTFILES"
    $DRY_RUN && warn "DRY RUN MODE — no changes will be made"
    echo ""

    detect_aur_helper
    install_packages
    create_core_symlinks
    install_extra_packages
    create_extra_symlinks
    install_fonts
    set_default_shell
    post_install_notes_full
}

main_full "$@"
