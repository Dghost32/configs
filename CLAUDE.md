# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal dotfiles for an Arch/Manjaro + Hyprland system (NVIDIA RTX 4060). Based on JaKooLit's Hyprland dotfiles v2.3.15 with extensive customization. Configs cover hyprland, neovim, wezterm, zsh, git, zed, and vim.

## Bootstrap / Install

```bash
./install.sh              # Core: hyprland, nvim, wezterm, zsh, git, fonts
./install-full.sh         # Full: core + vim, zed, ssh
./install.sh --dry-run    # Preview without changes
```

Both scripts detect yay/paru (or auto-install yay), install packages, create symlinks (backup existing to `*.bak`), copy fonts, and set zsh as default shell.

## Key Commands

```bash
hyprctl reload                      # Reload hyprland config
hyprctl clients                     # Inspect running windows (class, title, tags)
hyprctl layers                      # Inspect layers (waybar, rofi, etc.)
hyprctl keyword <section>:<opt> <v> # Test runtime config change
hyprctl getoption <section>:<opt>   # Check if option exists

# Check for config errors after reload
grep -i "ERR\|WARN\|invalid\|unknown" /run/user/1000/hypr/*/hyprland.log | grep -v "aquamarine\|libinput\|libseat"
```

## Repository Layout

| Directory | Purpose | Editable? |
|-----------|---------|-----------|
| `hypr/configs/` | System defaults (keybinds, etc.) | No — overwritten by upgrades |
| `hypr/UserConfigs/` | User customizations (window rules, keybinds, settings) | Yes |
| `hypr/scripts/` | System utility scripts (48 scripts) | Caution — may be overwritten |
| `hypr/UserScripts/` | User scripts (protected from upgrades) | Yes |
| `hypr/animations/` | 36 animation presets | Read-only (selected via script) |
| `nvim/` | Neovim config (lazy.nvim architecture) | Yes |
| `terminal/.zshrc` | Zsh entry point (sources `~/zshrc/init.sh`) | Yes |
| `terminal/zshrc/` | Modular zsh config (plug, opts, env, aliases) | Yes |
| `terminal/wezterm/` | WezTerm config (Catppuccin Mocha, CTRL+S leader) | Yes |
| `terminal/ssh/` | SSH client config | Yes |
| `zed/` | Zed editor settings + keymap | Yes |
| `vim/` | Legacy vim config (CoC-based) | Yes |
| `git/` | Global gitconfig + gitignore | Yes |
| `fonts/` | JetBrains Mono Nerd Font TTFs (copied, not symlinked) | Static |

## Hyprland Config Architecture

See `hypr/CLAUDE.md` for detailed Hyprland-specific guidance (syntax, source chain, theming pipeline, NVIDIA notes).

**Source chain:** `hyprland.conf` sources `configs/Keybinds.conf` first, then 11 `UserConfigs/*.conf` files, then `monitors.conf` + `workspaces.conf`.

**Hub pattern:** `UserConfigs/WindowRules.conf` sources 11 per-app rule files from `UserConfigs/apps/`. `UserConfigs/UserKeybinds.conf` sources 5 categorized binding files from `UserConfigs/bindings/`.

**Tag-based opacity:** All windows get `tag +default-opacity`. Apps opt out with `tag -default-opacity` before setting custom opacity. Bottom of WindowRules.conf applies default opacity to remaining tagged windows.

**Keybind format:** Use `bindd` (bind with description, 3rd positional arg). Flag combos: `bindeld` = bind+e+l+d, `bindlnd` = bind+l+n+d.

### Hyprland 0.53+ Syntax (CRITICAL)

Always use new syntax — old format causes silent failures:
```ini
# CORRECT (0.53+)
windowrule = float on, match:class ^(kitty)$
windowrule = tag +browser, match:class ^([Ff]irefox)$
layerrule = blur on, match:namespace waybar

# WRONG (pre-0.53) — DO NOT USE
windowrule = float, class:^(kitty)$
layerrule = blur, waybar
```

Key changes: `class:` → `match:class`, boolean actions need `on` (`float on`, `center on`, `pin on`), `noblur` → `no_blur on`, `ignorezero` → `ignore_alpha 0`.

## Neovim Architecture

**Entry point:** `nvim/init.lua` — bootstraps lazy.nvim, imports all `lua/plugins/*.lua`, then loads core modules.

**Core modules:**
- `lua/opts.lua` — vim options
- `lua/keymaps.lua` — global keymaps (all have `desc` for which-key)
- `lua/autocmds.lua` — autocommands

**Plugin domains** (`lua/plugins/`, 10 files):
- `ui.lua` — catppuccin, lualine, barbar, alpha, noice, indent-blankline
- `editor.lua` — neo-tree, toggleterm, comment, autopairs, persistence
- `telescope.lua` — fuzzy finder with fzf-native and frecency
- `lsp.lua` — native LSP + mason (ensure_installed: lua_ls, ts_ls, pyright, html, cssls, jsonls, bashls, tailwindcss)
- `completion.lua` — nvim-cmp + luasnip
- `git.lua` — gitsigns, neogit, diffview
- `ai.lua` — copilot.lua + codecompanion (Anthropic API via 1Password)
- `treesitter.lua` — syntax highlighting (30+ languages)
- `tools.lua` — conform (formatter), nvim-lint, code_runner, rest.nvim, todo-comments
- `which-key.lua` — keybind hints

**Key conventions:** All keymaps use `vim.keymap.set` with `desc`. All plugins use lazy-loading (event/cmd/keys). Theme is Catppuccin Mocha across nvim, wezterm, and zed. Note: `tsserver` is renamed to `ts_ls` in mason-lspconfig.

## Zsh Architecture

`.zshrc` sources `~/zshrc/init.sh`, which loads:
- `plug.sh` — zinit plugin manager (fzf-tab, zsh-autosuggestions, syntax-highlighting, etc.)
- `opt.sh` — shell options
- `env.sh` — PATH, EDITOR, etc.
- `aliases.sh` — eza-based ls/ll/la/tree aliases

## Conventions

- **Backup before rewriting:** Always create `.bak` before major file changes
- **Theme consistency:** Catppuccin Mocha across all tools
- **Symlink map:** `install.sh` defines which repo paths link where (hypr→~/.config/hypr, nvim→~/.config/nvim, etc.)
- **Variables:** `$UserConfigs`, `$scriptsDir`, `$UserScripts`, `$mainMod=SUPER`, `$term=wezterm`, `$files=nautilus`
