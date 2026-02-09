--[[ opts.lua ]]
local opt = vim.opt

-- [[ Context ]]
opt.number = true
opt.numberwidth = 1
opt.relativenumber = true
opt.ruler = true
opt.signcolumn = "yes"

-- [[ Clipboard ]]
opt.clipboard = "unnamedplus"

-- [[ Commands ]]
opt.showcmd = true

-- [[ Update time ]]
opt.updatetime = 300

-- [[ Cursor ]]
opt.cursorline = true
opt.cursorcolumn = false
opt.lazyredraw = false
opt.mouse = "a"
opt.whichwrap:append("<>[]hl")
opt.cmdheight = 0

-- [[ Encoding ]]
opt.encoding = "utf8"
opt.fileencoding = "utf8"

-- [[ Theme ]]
opt.syntax = "ON"
opt.termguicolors = true
opt.showmatch = true
opt.laststatus = 2
opt.showmode = false
opt.showtabline = 2

-- [[ Search ]]
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- [[ Whitespace ]]
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.smartindent = true

-- [[ Splits ]]
opt.splitright = true
opt.splitbelow = true

-- [[ Folding ]]
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldclose = "all"

-- [[ Disable netrw (using neo-tree) ]]
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
