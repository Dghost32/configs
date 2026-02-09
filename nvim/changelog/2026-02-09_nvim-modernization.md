# Neovim Config Modernization — Changelog

**Date:** 2026-02-09
**Source:** PRP/NVIM_IMPROVEMENTS.md (kickstart.nvim, lazy.nvim, Zed editor)

---

## Architecture Overhaul

### Before
```
lua/plug.lua          -- 351 lines, ALL 68 plugins in one file
lua/config/*.lua      -- 24 separate config files
lua/keys.lua          -- 55+ keymaps without desc, using old API
lua/vars.lua          -- dead code
lua/diagnostics.lua   -- commented out, unused
```

### After
```
init.lua              -- lazy.nvim bootstrap + { import = "plugins" }
lua/plugins/
  ui.lua              -- catppuccin, lualine, barbar, alpha, noice, indent, cursorline, barbecue
  editor.lua          -- autopairs, comment, surround, easymotion, visual-multi, neoscroll
  telescope.lua       -- telescope + fzf-native + frecency
  lsp.lua             -- native lspconfig + mason + lspsaga + trouble
  completion.lua      -- nvim-cmp + luasnip + friendly-snippets + lspkind
  git.lua             -- gitsigns + neogit + diffview
  ai.lua              -- copilot.lua + codecompanion (Anthropic + Copilot)
  treesitter.lua      -- treesitter + autotag
  tools.lua           -- neo-tree, toggleterm, code-runner, conform, persistence, vim-test, etc.
  which-key.lua       -- which-key with group definitions
lua/opts.lua          -- cleaned (fixed shiftwidth conflict, removed dead code)
lua/keymaps.lua       -- all keymaps with desc fields, vim.keymap.set API
lua/autocmds.lua      -- undercurl + highlight on yank
lua/utils/            -- logos, icons (preserved)
```

## Plugin Changes

### Removed (15 plugins)
| Plugin | Reason |
|--------|--------|
| `VonHeikemen/lsp-zero.nvim` | Deprecated; replaced by native LSP setup |
| `github/copilot.vim` | Replaced by `zbirenbaum/copilot.lua` (Lua-native) |
| `zbirenbaum/copilot-cmp` | Replaced by copilot.lua suggestion panel |
| `CopilotC-Nvim/CopilotChat.nvim` | Replaced by codecompanion.nvim |
| `codecompanion.nvim` (duplicate) | Was listed twice in plug.lua |
| `catppuccin/nvim` (duplicate) | Was listed twice in plug.lua |
| `junegunn/fzf` | Replaced by telescope |
| `junegunn/fzf.vim` | Replaced by telescope live_grep |
| `ibhagwan/fzf-lua` | Only used as optional neogit dep |
| `sbdchd/neoformat` | Replaced by conform.nvim |
| `michaelb/sniprun` | Redundant with code_runner.nvim |
| `giusgad/pets.nvim` + `hologram.nvim` | Novelty plugins |
| `lunarvim/lunar.nvim` | Unused theme |
| `EdenEast/nightfox.nvim` | Unused theme |
| `chaoren/vim-wordmotion` | Barely configured, broken lazy loading |
| `nvim-lua/popup.nvim` | Deprecated, telescope doesn't need it |

### Added (5 plugins)
| Plugin | Purpose |
|--------|---------|
| `folke/which-key.nvim` | Self-documenting keybinds (press leader to see options) |
| `folke/persistence.nvim` | Session management (Zed-like "open recent folder") |
| `nvim-telescope/telescope-frecency.nvim` | Recent files ranked by frequency + recency |
| `sindrets/diffview.nvim` | Zed-like git compare view (side-by-side diff, file history) |
| `stevearc/conform.nvim` | Modern formatter (replaces neoformat + LspZeroFormat) |

### Upgraded
| Plugin | Change |
|--------|--------|
| `copilot.vim` → `copilot.lua` | Vimscript → Lua-native Copilot |
| `codecompanion.nvim` | From `config = true` to full Anthropic + Copilot setup |
| `lspconfig` | From lsp-zero wrapper to native setup with mason ensure_installed |
| `telescope.nvim` | From empty setup to proper config with sorting, layout, hidden files |

## Keymaps

### All Existing Keymaps Preserved
- 55+ keymaps migrated from `nvim_set_keymap` to `vim.keymap.set`
- All keymaps now have `desc` field for which-key discoverability
- Lspsaga keymaps inlined into plugin spec (gh, gr, gd, K, pd, pt, gt, leader+o, Alt+d)
- Barbar keymaps inlined into plugin spec (Alt+1-9, Alt+,/., Alt+p/c, Ctrl+p)
- Format keymaps (`<leader>z`, `<leader>g`) now use conform.nvim

### New Keybinds
| Keybind | Action | Source |
|---------|--------|--------|
| `<leader>aa` | AI actions menu | codecompanion |
| `<leader>ac` | AI chat toggle | codecompanion |
| `<leader>ai` | AI inline assist | codecompanion |
| `<leader>ps` | Restore session | persistence.nvim |
| `<leader>pl` | Restore last session | persistence.nvim |
| `<leader>pd` | Don't save session | persistence.nvim |
| `<leader>fr` | Recent files (frecency) | telescope-frecency |
| `<leader>fo` | Old files | telescope |
| `<leader>fk` | Search keymaps | telescope |
| `<leader>gd` | Git diff view | diffview |
| `<leader>gh` | File git history | diffview |
| `<leader>gH` | Branch git history | diffview |
| `<leader>gx` | Close diff view | diffview |
| `<leader>gg` | Open Neogit | neogit |
| `<leader>xw` | Workspace diagnostics | trouble |
| `<leader>xd` | Document diagnostics | trouble |
| `<leader>ca` | Code action (LSP) | lspconfig LspAttach |
| `<C-c>` (i) | Copilot accept | copilot.lua |
| `<C-x>` (i) | Copilot dismiss | copilot.lua |
| `<C-\>` | Copilot panel | copilot.lua |

## Fixes Applied
- **shiftwidth conflict**: Removed duplicate `sw = 2` that overrode `shiftwidth = 4`
- **Dead code removed**: coq_settings, prettier autoformat, packer packpath, t_co=256
- **Broken "Find project" button**: Replaced with session restore and frecency
- **Colorscheme mismatch**: Changed from tokyonight-night to catppuccin-mocha (matches Zed)
- **Empty telescope config**: Added proper defaults (sorting, layout, hidden files, fzf-native)
- **Plugin duplicates**: codecompanion (x2) and catppuccin (x2) consolidated
- **Conflicting keymaps**: lspsaga `gd`/`K` now properly take precedence (richer features)
- **Missing lazy loading**: All plugins now have proper `event`, `cmd`, `keys`, or `ft` triggers
- **tsserver → ts_ls**: Updated deprecated LSP server name

## Backup
- Full backup at `nvim.bak/` (pre-modernization state)

## Plugin Count
| | Before | After |
|---|--------|-------|
| Total plugins | 68 | ~40 |
| Plugin files | 1 (plug.lua) | 10 (lua/plugins/) |
| Config files | 24 (lua/config/) | 0 (all inlined) |
| Duplicate plugins | 3 | 0 |
