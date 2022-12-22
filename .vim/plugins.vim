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

" icons
Plug 'ryanoasis/vim-devicons'
 
" Tree
Plug 'scrooloose/nerdtree'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 
"
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
Plug 'mlaursen/vim-react-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-json'
Plug 'mattn/emmet-vim'
"Plug 'valloric/youcompleteme'

" Autoimport
Plug 'kristijanhusak/vim-js-file-import'

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
Plug 'scrooloose/nerdcommenter'
Plug 'elzr/vim-json'
Plug 'kien/ctrlp.vim'
Plug 'andrewradev/tagalong.vim'
Plug 'tpope/vim-repeat'

" format
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

" git
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim'
Plug 'mhinz/vim-signify'

" copilot
Plug 'github/copilot.vim'

" live server
Plug 'manzeloth/live-server'

call plug#end()
