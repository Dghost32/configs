-- [[ LEADER ]]
vim.g.mapleader = "<Space>"
vim.g.localleader = "<Space>"

-- [[ IMPORTS ]]
require('vars')        -- Variables
require('opts')        -- Options
require('autocmds')    -- Autocommands
require('keys')        -- Keymaps
require('plug')        -- Plugins
require('diagnostics') -- Diagnostics

-- [[ PLUGINS CONFIG ]]
require('config.cmp')   -- Autocompletion
require('config.barbar.keymaps') -- Bufferline Keymaps
require('config.hlchunk')        -- Highlight current chunk
