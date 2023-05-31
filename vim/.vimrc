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
colorscheme catppuccin 
