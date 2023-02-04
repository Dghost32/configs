let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'norcalli/nvim-colorizer.lua'

" status bar
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" Themes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

"" TERMINAL 
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

"" MINIMAP 
Plug 'echasnovski/mini.map'

" icons
Plug 'ryanoasis/vim-devicons'
 
" Tree
Plug 'scrooloose/nerdtree'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" typing
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'vim-autoformat/vim-autoformat'

" tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" autocomplete
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-tabnine'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc-highlight'
Plug 'yaegassy/coc-htmldjango', {'do': 'yarn install --frozen-lockfile'}
Plug 'nacro90/numb.nvim'
"Plug 'valloric/youcompleteme'

" Autoimport
"Plug 'ludovicchabant/vim-gutentags'
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

" test
Plug 'tyewang/vimux-jest-test'
Plug 'janko-m/vim-test'

" IDE
Plug 'ervandew/supertab'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi'
Plug 'easymotion/vim-easymotion'
Plug 'yggdroot/indentline'
Plug 'justinmk/vim-sneak'
Plug 'scrooloose/nerdcommenter'
Plug 'elzr/vim-json'
Plug 'kien/ctrlp.vim'
Plug 'andrewradev/tagalong.vim'
Plug 'tpope/vim-repeat'

"" SOFT SCROLL
Plug 'karb94/neoscroll.nvim'

" format
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'tweekmonster/django-plus.vim', { 'for': ['python', 'htmldjango', 'html'] }

" git
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'lewis6991/gitsigns.nvim'

" copilot
"Plug 'github/copilot.vim'

"" GṔT
Plug 'jessfraz/openai.vim'

" live server
Plug 'manzeloth/live-server'

"" PHP
Plug 'stanangeloff/php.vim'
Plug 'rayburgemeestre/phpfolding.vim'

call plug#end()
