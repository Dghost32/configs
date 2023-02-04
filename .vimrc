set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax on
set showcmd
set ruler
set cursorline
set encoding=utf-8
set showmatch
set termguicolors
set sw=2
set relativenumber
"so ~/.vim/vam.vim
so ~/.vim/plugins.vim
so ~/.vim/plugin-config.vim
so ~/.vim/maps.vim

"colorscheme molokai
"let g:molokai_original = 1

colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"

"set background=dark
set laststatus=2
set noshowmode
highlight Normal ctermbg=NONE


lua require'colorizer'.setup()

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

"" SETUPS
lua require('neoscroll').setup()
lua require('numb').setup()
lua require("toggleterm").setup()
lua require("nvim-tree").setup()
lua require('gitsigns').setup()
