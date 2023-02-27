-- Configuración general
vim.opt.mouse = 'a'
vim.opt.numberwidth = 1
vim.opt.clipboard = 'unnamedplus'
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.encoding = 'utf-8'
vim.opt.showmatch = true
vim.opt.termguicolors = true
vim.opt.sw = 2
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.cmd('highlight Normal ctermbg=NONE')

-- Búsqueda
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Plegado
vim.opt.foldmethod = 'syntax'
vim.opt.foldclose = 'all'
vim.opt.foldlevel = 99

-- Configuración específica de Python
vim.cmd('autocmd FileType python set sw=4')
vim.cmd('autocmd FileType python set ts=4')
vim.cmd('autocmd FileType python set sts=4')
vim.cmd('autocmd BufNewFile,BufRead *.html set filetype=htmldjango')

-- Llamado a archivos .vim
vim.cmd('so ~/.vim/plugins.vim')
vim.cmd('so ~/.vim/plugin-config.vim')
vim.cmd('so ~/.vim/maps.vim')

-- Configuración de colores
vim.cmd('colorscheme gruvbox')

-- Configuración de Lua
require 'colorizer'.setup()
require('neoscroll').setup()
require('numb').setup()
require("nvim-tree").setup()
require('gitsigns').setup()
require("barbecue").setup()
require('nvim-cursorline').setup()
require('git-conflict').setup()
require('glow').setup()
--require("chatgpt").setup()

require("toggleterm").setup({
  active = true,
  on_config_done = nil,
  size = 50,
  open_mapping = [[<c-t>]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = false,
  direction = "vertical",
  shell = vim.o.shell,
  close_on_exit = true,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
