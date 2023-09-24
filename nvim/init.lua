--[[ init.lua ]]
-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"

vim.g.mapleader = "<Space>"
vim.g.localleader = "<Space>"

-- [[ IMPORTS ]]
require('vars')        -- Variables
require('opts')        -- Options
require('keys')        -- Keymaps
require('plug')        -- Plugins
require('diagnostics') -- Diagnostics

-- [[ PLUGINS CONFIG ]]
require('config.lsp')   -- Language Servers
require('config.mason') -- LSP Install
require('config.cmp')   -- Autocompletion
require('config.ts')    -- Treesiter
--require('config.nvimTree')       -- Filesystem navigation
--require('config.lualine')        -- Status Line
require('config.barbecue')       -- Breadcrumbs
require('config.autopairs')      -- Autopairs
require('config.cursorline')     -- Cursorline, Highlight words and lines on the cursor for Neovim
--require('config.barbar.config')  -- Bufferline Config
require('config.barbar.keymaps') -- Bufferline Keymaps
require('config.toggleterm')     -- Terminal
require('config.telescope')      -- Telescope
require('config.neoscroll')      -- Neoscroll, smooth scrolling
require('config.gitsigns')       -- Gitsigns
require('config.codeRunner')     -- Code Runner
require('config.lspsaga')        -- LSP Saga
require('config.hlchunk')        -- Highlight current chunk
