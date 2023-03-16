-- Configuración general
vim.opt.number = true
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
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldclose = 'all'
vim.opt.foldlevel = 99

-- Configuración específica de Python
vim.cmd('autocmd FileType python set sw=4')
vim.cmd('autocmd FileType python set ts=4')
vim.cmd('autocmd FileType python set sts=4')
--vim.cmd('autocmd BufNewFile,BufRead *.html set filetype=htmldjango')

-- Llamado a archivos .vim
vim.cmd('so ~/.vim/plugins.vim')
vim.cmd('so ~/.vim/plugin-config.vim')
vim.cmd('so ~/.vim/maps.vim')

-- Configuración de colores
vim.cmd('colorscheme catppuccin')

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

require('hologram').setup{
    auto_display = true -- WIP automatic markdown image display, may be prone to breaking
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
}
