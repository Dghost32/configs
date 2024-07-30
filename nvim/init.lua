-- [[ LEADER ]]
vim.g.mapleader = "<Space>"
vim.g.localleader = "<Space>"

-- [[ IMPORTS ]]
require('plug')        -- Plugins
require('vars')        -- Variables
require('opts')        -- Options
require('autocmds')    -- Autocommands
require('keys')        -- Keymaps

-- require('diagnostics') -- Diagnostics

-- [[ PLUGINS CONFIG ]]
require('config.cmp')            -- Autocompletion
require('config.barbar.keymaps') -- Bufferline Keymaps
require('config.hlchunk')        -- Highlight current chunk
