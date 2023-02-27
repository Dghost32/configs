" HTML, JSX
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'
" Lightlane
let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste'], [], ['relativepath', 'modified']],
      \   'right': [['kitestatus'], ['filetype', 'percent', 'lineinfo'], ['gitbranch']]
      \ },
      \ 'inactive': {
      \   'left': [['inactive'], ['relativepath']],
      \   'right': [['bufnum']]
      \ },
      \ 'component': {
      \   'bufnum': '%n',
      \   'inactive': 'inactive'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'kitestatus': 'kite#statusline'
      \ },
      \ 'colorscheme': 'gruvbox',
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
      \}

"  nerdtree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowLineNumbers=1
let NERDTreeMapOpenInTab='t'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
""""""""""""""
" ULTISNIPS "
"""""""""""""
let g:UltiSnipsSnippetDirectories=[$HOME.'/configs/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" kite
let g:kite_supported_languages = ['*']

" tmux navigator
let g:tmux_navigator_no_mappings = 1

autocmd FileType scss setl iskeyword+=@-@

" git blamer
let g:blamer_enabled = 1
let g:blamer_delay = 100
let g:blamer_prefix = ' -> '
let g:blamer_template = '( <commit-short> ) <committer>, <committer-time> ⚫<summary>'

" vim fugitive
command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)


" Default options are --nogroup --column --color
let s:ag_options = ' --one-device --skip-vcs-ignores --smart-case '

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(
  \   <q-args>,
  \   s:ag_options,
  \  <bang>0 ? fzf#vim#with_preview('up:60%')
  \        : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0
  \ )


command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" fugitive always vertical diffing
set diffopt+=vertical

" prettier 
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1

let $FZF_DEFAULT_OPTS='--layout=reverse'

"""""""
" COC "
"""""""
" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-h> for select text for visual placeholder of snippet.
"vmap <C-h> <Plug>(coc-snippets-select)

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

 "Use <C-j> for jump to next placeholder, it's default of coc.nvim
"let g:coc_snippet_next = '<C-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"let g:coc_snippet_prev = '<C-k>'

" Use <C-h> for both expand and jump (make expand higher priority.)
"imap <C-h> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
"xmap <leader>x  <Plug>(coc-convert-snippet)

" Add `:Format` command to format current buffer
"command! -nargs=0 Format :call CocActionAsync('format')
" Add `:Fold` command to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer
"command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

"autocmd CursorHold * silent call CocActionAsync('highlight')

"let g:coc_global_extensions = [
      "\ 'coc-tsserver',
      "\ 'coc-eslint',
      "\ 'coc-snippets',
      "\ ]


