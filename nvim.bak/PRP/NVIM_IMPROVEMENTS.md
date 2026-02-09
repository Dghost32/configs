# Neovim Config Modernization — PRP

## Sources
- kickstart.nvim (nvim-lua/kickstart.nvim) — gold-standard minimal config
- lazy.nvim (folke/lazy.nvim) — plugin manager best practices
- Zed editor (zed.dev) — UX features to replicate
- User's `lazy-nvim/` config — already has modern patterns to cherry-pick
- Previous session pattern: Omarchy improvements to Hyprland config

## Guiding Principle
**Keep all existing keymaps and features.** Modernize architecture, eliminate redundancy, add missing features. Simple > complex.

---

## CURRENT STATE AUDIT

### Critical Issues Found

| Issue | Severity | Details |
|-------|----------|---------|
| lsp-zero v1.x | HIGH | Deprecated; v4.x exists but native LSP is now standard. Only `tsserver` configured |
| codecompanion.nvim DUPLICATE | HIGH | Listed twice in plug.lua (lines 59 and 226) |
| catppuccin/nvim DUPLICATE | MEDIUM | Listed twice in plug.lua (lines 76 and 92) |
| 4 overlapping fuzzy finders | MEDIUM | telescope + fzf + fzf.vim + fzf-lua — only telescope is actually used |
| No keymap descriptions | MEDIUM | All keymaps lack `desc` field — undiscoverable, no which-key support |
| Conflicting keymaps | MEDIUM | `lspsaga.lua` defines `gd`, `K` that override `keys.lua` definitions |
| Copilot triple-stack | MEDIUM | copilot.vim + copilot-cmp + CopilotChat — redundant |
| Empty telescope config | LOW | `telescope.setup({})` — zero configuration |
| Broken "Find project" | LOW | alpha.lua references `Telescope projects` but no project plugin installed |
| `hlchunk.lua` misnomer | LOW | File loads `ibl` (indent-blankline), not hlchunk |
| shiftwidth conflict | LOW | `opts.lua` sets `shiftwidth=4` then `sw=2` (line 53 overrides line 50) |
| No lazy loading | LOW | Most plugins load at startup — no `event`, `cmd`, `keys`, or `ft` triggers |
| Dead code | LOW | packer packpath reference in vars.lua, coq settings in opts.lua, commented ultisnips |

### What's Good (Keep)

- Leader = Space (standard)
- Modular file structure (init.lua → requires)
- gitsigns with inline blame (well configured)
- neo-tree for file explorer
- noice.nvim for better UI
- treesitter for syntax
- barbar for buffer tabs with Alt+1-9
- toggleterm with Ctrl+T
- Alt+J/K line moving
- All existing keymaps (user muscle memory)

---

## HIGH-IMPACT IMPROVEMENTS

### 1. Architecture: Split `plug.lua` into `lua/plugins/*.lua`

**Why:** Single 351-line file with 68 plugins is hard to maintain. Kickstart.nvim and lazy.nvim best practices use per-domain files.

**Current:**
```
lua/plug.lua          -- ALL 68 plugins in one file
lua/config/*.lua      -- 24 separate config files
```

**Proposed:**
```
lua/plugins/
  ui.lua              -- themes, statusline, bufferline, dashboard, noice, icons
  editor.lua          -- autopairs, surround, comment, easymotion, cursorline, indent
  telescope.lua       -- telescope + extensions (replaces fzf stack)
  lsp.lua             -- lspconfig, mason, mason-lspconfig, lspsaga, trouble
  completion.lua      -- nvim-cmp, luasnip, friendly-snippets, lspkind
  git.lua             -- gitsigns, neogit, diffview
  ai.lua              -- copilot.lua, codecompanion (Anthropic + Copilot)
  treesitter.lua      -- treesitter, autotag
  tools.lua           -- toggleterm, code-runner, todo-comments, markdown
  which-key.lua       -- which-key with group definitions
```

**Key change:** Plugin config moves INTO the spec (via `opts` or `config` function). Eliminates the separate `lua/config/` directory. Each plugin file is self-contained.

```lua
-- Example: lua/plugins/git.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = { add = { text = "│" }, ... },
      current_line_blame = true,
    },
    keys = {
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", desc = "Reset buffer" },
      -- ... all existing git keymaps preserved
    },
  },
}
```

### 2. Replace lsp-zero with Native LSP

**Why:** lsp-zero v1.x is deprecated. Native setup is simpler and kickstart.nvim proves it only takes ~40 lines.

**Current:** lsp-zero v1.x minimal preset, only `tsserver` configured, mason with no `ensure_installed`.

**Proposed:**
```lua
-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "ts_ls", "pyright", "html", "cssls",
          "jsonls", "bashls", "tailwindcss",
        },
        automatic_installation = true,
      })
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup_handlers({
        function(server) -- default handler
          require("lspconfig")[server].setup({ capabilities = capabilities })
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = { Lua = { workspace = { checkThirdParty = false } } },
          })
        end,
      })
    end,
  },
}
```

**Note:** `tsserver` was renamed to `ts_ls` in recent mason-lspconfig.

### 3. Deduplicate & Modernize AI Stack

**Why:** Currently 4 AI plugins with overlap. The `lazy-nvim/` config already solved this.

**Current (nvim/):**
- `github/copilot.vim` — Vimscript Copilot (old)
- `zbirenbaum/copilot-cmp` — Copilot → cmp source
- `CopilotC-Nvim/CopilotChat.nvim` — Chat UI
- `olimorris/codecompanion.nvim` — (listed TWICE, `config = true` only)

**Proposed (cherry-picked from lazy-nvim/):**
- `zbirenbaum/copilot.lua` — Lua-native Copilot (replaces copilot.vim)
- `olimorris/codecompanion.nvim` — Single AI chat/assistant (replaces CopilotChat, supports Claude + Copilot)

**codecompanion benefits over CopilotChat:**
- Supports Anthropic Claude (with extended thinking!), OpenAI, Copilot, Ollama, Gemini
- Inline code assists (like Zed's inline AI)
- Chat with file context (@buffers, @files, @lsp)
- VectorCode integration for repo-wide code search
- Prompt library for custom workflows

**Config (from lazy-nvim/ with Anthropic API):**
```lua
{
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  opts = {
    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = { api_key = "cmd:op read op://personal/Anthropic_API/credential --no-newline" },
          schema = { extended_thinking = { default = true } },
        })
      end,
    },
    strategies = {
      chat = { adapter = "anthropic" },
      inline = { adapter = "copilot" },
    },
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "AI actions", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>CodeCompanionChat toggle<CR>", desc = "AI chat toggle" },
    { "<leader>ai", "<cmd>CodeCompanion<CR>", desc = "AI inline", mode = { "n", "v" } },
  },
}
```

### 4. Add which-key.nvim (Self-Documenting Keybinds)

**Why:** Like `bindd` in the Hyprland refactor — makes all keybinds discoverable. Press `<leader>` and see what's available.

**How:** Add which-key + convert all keymaps to use `desc` field. Define groups for leader prefixes.

```lua
-- lua/plugins/which-key.lua
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>t", group = "Tab/Test" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>n", group = "Tree" },
        { "<leader>b", group = "Buffer" },
        { "<leader>a", group = "AI" },
        { "<leader>o", group = "Outline" },
      },
    },
  },
}
```

**All existing keymaps preserved**, just adding `desc` field to each:
```lua
-- Before (undiscoverable):
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")

-- After (shows in which-key popup):
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
```

### 5. Add "Open Recent Folder" (Zed-like Project Switching)

**Why:** User specifically requested this. Zed's Ctrl+Shift+P → "Open Recent" is a key workflow.

**Option A: persistence.nvim (folke)** — Session management. Auto-saves session per directory. Restore with one command.

**Option B: telescope-project.nvim** — Browse recent projects in telescope.

**Recommended: Both** — persistence for session restore + telescope-frecency for recent files:

```lua
-- Session management
{
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    { "<leader>ps", function() require("persistence").load() end, desc = "Restore session" },
    { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<leader>pd", function() require("persistence").stop() end, desc = "Don't save session" },
  },
}

-- Recent files (frecency = frequency + recency)
{
  "nvim-telescope/telescope-frecency.nvim",
  config = function() require("telescope").load_extension("frecency") end,
  keys = {
    { "<leader>fr", "<cmd>Telescope frecency<CR>", desc = "Recent files (frecency)" },
  },
}
```

Also fix the broken alpha.lua "Find project" button to actually work.

### 6. Git Compare View (Zed-like Diff)

**Why:** User specifically requested "git compare page like in Zed." diffview.nvim is already a dependency of neogit but has zero config.

**Zed's git features:**
- Side-by-side diff view
- File-by-file change browser
- Branch comparison
- Inline git blame (already have via gitsigns)

**diffview.nvim gives all of this:**
```lua
{
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff view" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File git history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Branch git history" },
    { "<leader>gc", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { layout = "diff2_horizontal" },
      merge_tool = { layout = "diff3_mixed" },
    },
  },
}
```

### 7. Remove Redundant Fuzzy Finders

**Why:** 4 overlapping plugins. Only telescope is actually used in keymaps.

**Remove:**
- `junegunn/fzf` — not used in keymaps (only `<leader>ag` via fzf.vim)
- `junegunn/fzf.vim` — replace `Ag` with `Telescope live_grep`
- `ibhagwan/fzf-lua` — only listed as neogit optional dep

**Keep & enhance:**
- `telescope.nvim` — configure properly (currently empty setup)
- Add file browser, frecency, and fzf-native sorting

```lua
{
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
      },
      pickers = {
        find_files = { hidden = true },
      },
    })
    telescope.load_extension("fzf")
  end,
  keys = {
    -- ALL existing telescope keymaps preserved:
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
    { "<leader>ob", "<cmd>Telescope buffers<CR>", desc = "Open buffers" },
    { "<leader>ss", "<cmd>Telescope spell_suggest<CR>", desc = "Spell suggest" },
    -- Replace fzf.vim Ag:
    { "<leader>ag", "<cmd>Telescope live_grep<CR>", desc = "Grep (was Ag)" },
    -- New:
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
    -- Git (existing):
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
    { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
  },
}
```

### 8. Conform.nvim (Replace neoformat + LspZeroFormat)

**Why:** neoformat is not actively maintained. `LspZeroFormat` won't exist without lsp-zero. conform.nvim is the modern standard (used by kickstart.nvim + LazyVim).

```lua
{
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    -- Preserves existing <leader>z for format:
    { "<leader>z", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format file" },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      python = { "black" },
      html = { "prettierd" },
      css = { "prettierd" },
      json = { "prettierd" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
}
```

### 9. Theme: Match Zed's Catppuccin Mocha

**Why:** User uses Catppuccin Mocha in Zed with transparency. Currently using TokyoNight in nvim (mismatched).

```lua
{
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = true,
    integrations = {
      barbar = true,
      gitsigns = true,
      telescope = { enabled = true },
      treesitter = true,
      which_key = true,
      neotree = true,
      noice = true,
      lsp_saga = true,
      native_lsp = { enabled = true },
    },
  },
}
```

Change `opts.lua` colorscheme to `catppuccin-mocha`.

### 10. Cleanup Dead Code & Duplicates

**Remove from plug.lua:**
- Second `codecompanion.nvim` entry (line 226)
- Second `catppuccin/nvim` entry (line 92)
- `github/copilot.vim` (replaced by copilot.lua)
- `zbirenbaum/copilot-cmp` (replaced by copilot.lua suggestion panel)
- `CopilotC-Nvim/CopilotChat.nvim` (replaced by codecompanion)
- `junegunn/fzf` + `fzf.vim` + `ibhagwan/fzf-lua` (replaced by telescope)
- `sbdchd/neoformat` (replaced by conform.nvim)
- `michaelb/sniprun` (unused, code_runner.nvim covers this)
- `giusgad/pets.nvim` + `hologram.nvim` (novelty)
- `lunarvim/lunar.nvim` + `EdenEast/nightfox.nvim` (unused themes)
- `VonHeikemen/lsp-zero.nvim` (replaced by native LSP)
- `chaoren/vim-wordmotion` (barely configured, lazy with broken `fn` key)
- `nvim-lua/popup.nvim` (deprecated, telescope doesn't need it)
- `SmiteshP/nvim-navic` (duplicate entry, barbecue handles this)

**Remove from lua/config/:**
- All files that get inlined into plugin specs

**Remove from lua/:**
- `vars.lua` (only sets t_co=256 and dead packer reference)
- `diagnostics.lua` (commented out, unused)

**Fix in opts.lua:**
- Remove `sw = 2` (line 53, conflicts with `shiftwidth = 4` on line 50)
- Remove coq_settings (line 71, not using coq)
- Remove prettier autoformat (lines 82-83, conform handles this)

---

## IMPLEMENTATION PHASES

### Phase 1 — Architecture & Cleanup (foundation)
- [ ] Backup current config (`nvim.bak/`)
- [ ] Create `lua/plugins/` directory structure (10 files)
- [ ] Migrate all plugin specs from `plug.lua` → domain files
- [ ] Inline `lua/config/*.lua` into plugin specs
- [ ] Remove duplicates and dead plugins (15 removals)
- [ ] Fix opts.lua conflicts
- [ ] Remove `lua/vars.lua`, `lua/diagnostics.lua`
- [ ] Update `init.lua` entry point

### Phase 2 — LSP & Completion Modernization
- [ ] Replace lsp-zero v1.x with native LSP setup
- [ ] Configure mason with `ensure_installed` servers
- [ ] Add conform.nvim (replace neoformat + LspZeroFormat)
- [ ] Keep nvim-cmp + LuaSnip (working fine, just clean up config)
- [ ] Add copilot source to cmp if desired
- [ ] Fix lspsaga keymap conflicts

### Phase 3 — New Features (Zed-inspired)
- [ ] Add which-key.nvim + `desc` on ALL keymaps
- [ ] Add persistence.nvim (session management / open recent)
- [ ] Add telescope-frecency (recent files by frequency)
- [ ] Configure diffview.nvim (git compare view)
- [ ] Configure telescope properly (sorting, layout, hidden files)
- [ ] Fix alpha.lua "Find project" button
- [ ] Modernize AI stack (copilot.lua + codecompanion w/ Anthropic)

### Phase 4 — Polish
- [ ] Switch theme to Catppuccin Mocha (match Zed)
- [ ] Add lazy-loading triggers to all plugins
- [ ] Convert all `nvim_set_keymap` → `vim.keymap.set`
- [ ] Test all keymaps work correctly
- [ ] Create changelog

---

## KEYMAP PRESERVATION MAP

Every existing keymap is preserved. New features get NEW keys only.

| Existing Binding | Action | Status |
|-----------------|--------|--------|
| `<leader>w` | Save | KEEP |
| `<C-s>` (i/v) | Save | KEEP |
| `<leader>q` | Quit | KEEP |
| `<C-q>` (i/v) | Quit | KEEP |
| `<C-c>` (i) | Copilot accept | KEEP (update to copilot.lua) |
| `<leader>x` | Run code | KEEP |
| `gD` / `gd` | LSP declaration/definition | KEEP (via lspsaga) |
| `K` | Hover doc | KEEP (via lspsaga) |
| `gi` | LSP implementation | KEEP |
| `gh` | LSP finder | KEEP (lspsaga) |
| `gr` | Rename | KEEP (lspsaga) |
| `pd` / `pt` | Peek definition/type | KEEP (lspsaga) |
| `gt` | Go to type def | KEEP (lspsaga) |
| `<leader>o` | Outline | KEEP (lspsaga) |
| `<A-d>` | Float terminal | KEEP (lspsaga) |
| `<leader>xn/xp` | Diagnostic next/prev | KEEP |
| `<leader>hh/xx` | Show diagnostics | KEEP |
| `<leader>ff/fg/fh` | Telescope find/grep/help | KEEP |
| `<leader>ob` | Telescope buffers | KEEP |
| `<leader>ss` | Spell suggest | KEEP |
| `<leader>ag` | Grep (was Ag) | KEEP (use telescope) |
| `<leader>gs/gc/gb` | Git status/commits/branches | KEEP |
| `<leader>gR/gp` | Gitsigns reset/preview | KEEP |
| `gb` | Git blame line | KEEP |
| `<leader>gd` | Git diff | REMAP → diffview |
| `<leader>tt/tf/ts` | Test nearest/file/suite | KEEP |
| `<leader><Up/Down>` | Resize split | KEEP |
| `<C-Left/Right>` | Resize vertical | KEEP |
| `<A-j/k>` | Move line | KEEP |
| `<leader>tn/tc/to/tm` | Tab new/close/only/move | KEEP |
| `<leader>h/l` | Tab prev/next | KEEP |
| `<C-k/j>` | Move 10 lines | KEEP |
| `n/N` | Search centered | KEEP |
| `<C-a>` | Select all | KEEP |
| `</>` (v) | Better indent | KEEP |
| `,` | Quick semicolon | KEEP |
| `<leader>nt/nr/nf` | Neotree toggle/refresh/reveal | KEEP |
| `<leader>e` | Neotree focus | KEEP |
| `<C-h/l>` | Window nav | KEEP |
| `<leader>z` | Format (→ conform) | KEEP |
| `<leader>g` | Format (→ conform) | KEEP |
| `<A-,/.>` | Buffer prev/next | KEEP |
| `<A-1-9>` | Buffer goto N | KEEP |
| `<A-p>` | Buffer pin | KEEP |
| `<A-c>` | Buffer close | KEEP |
| `<C-p>` | Buffer pick | KEEP |
| `<C-t>` | Toggle terminal | KEEP |

### NEW Keybinds

| Binding | Action | Source |
|---------|--------|--------|
| `<leader>aa` | AI actions menu | codecompanion |
| `<leader>ac` | AI chat toggle | codecompanion |
| `<leader>ai` | AI inline assist | codecompanion |
| `<leader>ps` | Restore session | persistence.nvim |
| `<leader>pl` | Restore last session | persistence.nvim |
| `<leader>fr` | Recent files (frecency) | telescope-frecency |
| `<leader>fo` | Old files | telescope |
| `<leader>fk` | Search keymaps | telescope |
| `<leader>gh` | File git history | diffview |
| `<leader>gH` | Branch git history | diffview |

---

## PLUGIN COUNT

| | Before | After | Delta |
|---|---|---|---|
| Total plugins | 68 | ~40 | -28 |
| Plugin files | 1 (plug.lua) | 10 (lua/plugins/) | +9 files, better organized |
| Config files | 24 (lua/config/) | 0 (inlined) | -24 files |
| Duplicate plugins | 3 | 0 | -3 |
| Dead/unused plugins | ~15 | 0 | -15 |
| New plugins | — | 4 | which-key, persistence, frecency, conform |

---

## BACKUPS

Before any changes:
```
cp -r nvim/ nvim.bak/
```
