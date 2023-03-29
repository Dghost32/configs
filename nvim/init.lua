--[[ init.lua ]]
-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = "<Space>"
vim.g.localleader = "<Space>"

-- [[ IMPORTS ]]
require('vars') -- Variables
require('opts') -- Options
require('keys') -- Keymaps
require('plug') -- Plugins

-- [[ PLUGINS CONFIGS ]]
require('plugins.lsp')            -- Language Servers
require('plugins.mason')          -- LSP Install
require('plugins.lspsaga')        -- LSP Saga, LSP UI
require('plugins.cmp')
require('plugins.ts')             -- Treesiter
require('plugins.nvimTree')       -- Filesystem navigation
require('plugins.lualine')        -- Status Line
require('plugins.barbecue')       -- Breadcrumbs
require('plugins.autopairs')      -- Autopairs
require('plugins.cursorline')     -- Cursorline, Highlight words and lines on the cursor for Neovim
require('plugins.barbar.config')  -- Bufferline Config
require('plugins.barbar.keymaps') -- Bufferline Keymaps
require('plugins.toggleterm')     -- Terminal
require('plugins.telescope')      -- Telescope
require('plugins.neoscroll')      -- Neoscroll, smooth scrolling
require('plugins.gitsigns')       -- Gitsigns
require('plugins.webTools')
