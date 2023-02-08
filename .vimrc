set number
set mouse=a
set numberwidth=1
set clipboard+=unnamedplus
syntax on
set showcmd
set ruler
set cursorline
set encoding=utf-8
set showmatch
set termguicolors
set sw=2
set relativenumber
"set background=dark
set laststatus=2
set noshowmode
highlight Normal ctermbg=NONE
"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Folding
set foldmethod=syntax
set foldclose=all
set foldlevel=99

"" Python
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
" COMMENT THIS LINE IF YOU'RE NOT WORKING WITH DJANGO
au BufNewFile,BufRead *.html set filetype=htmldjango

"""""""""""""""""""""
"  CALL .VIM FILES  "
"""""""""""""""""""""
so ~/.vim/plugins.vim
so ~/.vim/plugin-config.vim
so ~/.vim/maps.vim

"""""""""""""""""
"  COLORSCHEME  "
"""""""""""""""""
colorscheme gruvbox

""""""""""""""""
"  LUA CONFIG  "
""""""""""""""""
lua << END
require'colorizer'.setup()

require('neoscroll').setup()

require('numb').setup()
 
require("nvim-tree").setup()

require('gitsigns').setup()

require("barbecue").setup()

require('nvim-cursorline').setup()

require('git-conflict').setup()

-- require("chatgpt").setup()

require("toggleterm").setup({
    active = true,
    on_config_done = nil,
    size = 50,
    open_mapping = [[<c-t>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_terminals = true,
		shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    direction = "vertical",
		shell = vim.o.shell,
    close_on_exit = true, -- close the terminal window when the process exits
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  }
)
END

