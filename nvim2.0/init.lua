--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"

vim.g.mapleader = "<Space>"
vim.g.localleader = "<Space>"

-- [[ IMPORTS ]]
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps
require('plug')      -- Plugins

-- [[ PLUGINS ]]
require('plugins.lsp')          -- Language Servers
require('plugins.mason')   -- Language Servers
require('plugins.ts')           -- Completion
require('plugins.nvimTree')     -- Status Line
require('plugins.lualine')      -- Status Line
require('plugins.barbecue')     -- Breadcrumbs

