--[[ opts.lua ]]
local opt = vim.opt -- set
local cmd = vim.cmd -- let

-- [[ Context ]]
opt.number = true         -- bool: Show line numbers
opt.numberwidth = 1       -- num:  Width of line number column
opt.relativenumber = true -- bool: Show relative line numbers
opt.ruler = true          -- bool: Show the cursor position
opt.signcolumn = "yes"    -- str:  Show the sign column

-- [[ Copy ]]
opt.clipboard = 'unnamedplus' -- str:  Use system clipboard

-- [[ Commands ]]
opt.showcmd = true -- bool: Show command in status line

-- [[ update time ]]
opt.updatetime = 300 -- num:  Delay before swap file is saved [[ Copilot ]]

-- [[ Cursor ]]
opt.cursorline = true         -- bool: Highlight the current line
opt.cursorcolumn = false      -- bool: Highlight the current column
opt.lazyredraw = false        -- bool: Don't redraw while executing macros
opt.mouse = 'a'               -- str:  Mouse mode
opt.whichwrap:append "<>[]hl" -- str:  Characters to wrap around
opt.cmdheight = 0             -- num:  Height of the command bar

-- [[ Filetypes ]]
opt.encoding = 'utf8'     -- str:  String encoding to use
opt.fileencoding = 'utf8' -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"        -- str:  Allow syntax highlighting
opt.termguicolors = true -- bool: If term supports ui color then enable
opt.showmatch = true     -- bool: Show matching brackets
opt.laststatus = 2       -- num:  Always show status line
opt.showmode = false     -- bool: Show current mode

-- [[ Search ]]
opt.hlsearch = true   -- bool: Highlight search matches
opt.incsearch = true  -- bool: Use incremental search
opt.ignorecase = true -- bool: Ignore case in search patterns
opt.smartcase = true  -- bool: Override ignorecase if search contains capitals

-- [[ Whitespace ]]
opt.expandtab = true   -- bool: Use spaces instead of tabs
opt.shiftwidth = 4     -- num:  Size of an indent
opt.softtabstop = 4    -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4        -- num:  Number of spaces tabs count for
opt.sw = 2             -- num:  Size of an indent
opt.smartindent = true -- bool: Insert indents automatically

-- [[ Splits ]]
opt.splitright = true -- bool: Place new window to right of current one
opt.splitbelow = true -- bool: Place new window below the current one

-- [[ Folding ]]
opt.foldmethod = 'expr'                     -- str:  Folding method
opt.foldexpr = 'nvim_treesitter#foldexpr()' -- str:  Folding expression
opt.foldlevel = 99                          -- num:  Initial fold level
opt.foldclose = 'all'                       -- str:  Close all folds when opening a new one

-- [[ Configuración de colores ]]
cmd('colorscheme catppuccin')

-- Coq completion settings
-- Set recommended to false
vim.g.coq_settings = { ["keymap.recommended"] = false }

-- Prettier format on save
cmd("let g:prettier#autoformat = 0")
cmd("let g:prettier#autoformat_require_pragma = 0")
