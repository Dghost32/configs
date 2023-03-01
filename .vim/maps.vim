let mapleader=" "

"""""""""""""
"  TESTING  "
"""""""""""""
nnoremap <Leader>t :TestNearest<CR>
nnoremap <Leader>T :TestFile<CR>
nnoremap <Leader>TT :TestSuite<CR>

""""""""""""""""""
"  SPLIT RESIZE  "
""""""""""""""""""
nnoremap <Leader><Down> :resize +2<CR> 
nnoremap <Leader><Up> :resize -2<CR> 
nnoremap <C-left> :vertical resize -2<CR> 
nnoremap <C-right> :vertical resize +2<CR> 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move current line / block with Alt-j/k a la vscode. "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

"""""""""""""""""""""""""
"  QUICK SEMICOLON (;)  "
"""""""""""""""""""""""""
nnoremap <silent>, $a;<Esc>

""""""""""""""""""""
"  WRITE AND EXIT  "
""""""""""""""""""""
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>

""""""""""""""""""""""""""""
"  DJANGO SAVE AND FORMAT  "
""""""""""""""""""""""""""""
nnoremap <leader>ds :let prettier#autoformat=0<CR>:CocCommand htmldjango.djlint.format<CR>:w<CR>

""""""""""""""""""""""""""""""
"  MARKDOWN SAVE AND FORMAT  "
""""""""""""""""""""""""""""""
nnoremap <leader>ms :let prettier#autoformat=0<CR>:CocCommand editor.action.formatDocument<CR>:w<CR>

""""""""""""""""""""""
"  SHORTER COMMANDS  "
""""""""""""""""""""""
cnoreabbrev tree NERDTreeToggle
cnoreabbrev blame Gblame
cnoreabbrev find NERDTreeFind
cnoreabbrev diff Gdiff

""""""""""""""""""""""""
" popupmenu completion "
""""""""""""""""""""""""
" CONFIRM
inoremap <silent><expr> <C-l> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" ESCAPE
"inoremap <expr> <Esc> coc#pum#visible() ? "\<C-e>" : "\<Esc>"
" GO DOWN
inoremap <silent><expr> <C-j>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
" GO UP
inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

""""""""""""""
"  NERDTREE  "
""""""""""""""
map <Leader>nt :NERDTreeFocus<CR>
map <Leader>e :NERDTreeToggle<CR>

"""""""""
"  FZF  "
"""""""""
map <Leader>p :Files<CR>
map <Leader>ag :Ag<CR>

"""""""""""""""""""""""""""""""""
"  TELESCOPE FILES AND BUFFERS  "
"""""""""""""""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files prompt_prefix=🔍<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"nnoremap <leader>hh <cmd>Telescope keymaps<cr>
nnoremap <leader>ss <cmd>Telescope spell_suggest<cr>

"""""""""""""""""
"  FORMAT FILE  "
"""""""""""""""""
nmap <Leader>py <Plug>(PrettierAsync)

""""""""""
"  TMUX  "
""""""""""
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <Leader><C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <Leader><C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

"""""""""""
"  GO-TO  "
"""""""""""
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
" find definition
nnoremap <silent> fd :call CocAction('doHover')<CR>

" Remap surround to lowercase s so it does not add an empty space
xmap s <Plug>VSurround
" diagnostics
nnoremap <leader>P :let @*=expand("%")<CR>

""""""""""""""""""""
"  TAB NAVIGATION  "
""""""""""""""""""""
map <Leader>h :tabprevious<cr>
map <Leader>l :tabnext<cr>

"""""""""""""
"  BUFFERS  "
"""""""""""""
map <Leader>ob :Buffers<cr>

" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

"""""""""""""""
"  MOVE TEXT  "
"""""""""""""""
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

""""""""""""""""""""""
"  FASTER SCROLLING  "
""""""""""""""""""""""
nnoremap <C-j> 10<C-e>
nnoremap <C-k> 10<C-y>
nmap <Leader>s <Plug>(easymotion-s2)

"""""""""
"  GIT  "
"""""""""
nnoremap <Leader>G :G<CR> 
nnoremap <Leader>gl :Gpull<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gs :Telescope git_status<CR>
nnoremap <Leader>gc :Telescope git_commits<CR>
nnoremap <Leader>gb :Telescope git_branches<CR>
nnoremap <leader>gR :Gitsigns reset_buffer<CR>
nnoremap <leader>gd :Gitsigns diffthis HEAD<CR>
" BLAME CURRENT LINE
nnoremap <silent>gb :Gitsigns blame_line<CR>
" SHOW CURRENT LINE DIFF
nnoremap <leader>gh :Gitsigns preview_hunk<CR>

"""""""""""""""""
"  CODE RUNNER  "
"""""""""""""""""
nnoremap <Leader>x :call Run()<cr>

" Use <c-space> to trigger completion.
"if &filetype == "javascript" || &filetype == "python"
  "inoremap <c-space> <C-x><C-u>
"else
  inoremap <silent><expr> <c-space> coc#refresh()
"endif

set splitright
function! OpenTerminal()
  " move to right most buffer
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")

  if bufType == "terminal"
    " close existing terminal
    execute "q"
  else
    " open terminal
    execute "vsp term://zsh"

    " turn off numbers
    execute "set nonu"
    execute "set nornu"

    " toggle insert on enter/exit
    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    " set maps inside terminal buffer
    execute "tnoremap <buffer> <C-h> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"
    execute "tnoremap <buffer> <C-\\><C-\\> <C-\\><C-n>"

    startinsert!
  endif
endfunction
"nnoremap <C-t> :call OpenTerminal()<CR>

inoremap <expr> <CR> ParensIndent()

function! ParensIndent()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<CR>\<ESC>O"
  endif
  
  return "\<CR>"
endfunction

inoremap <expr> <space> ParensSpacing()

function! ParensSpacing()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<space>\<space>\<left>"
  endif
  
  return "\<space>"
endfunction

inoremap <expr> <BS> ParensRemoveSpacing()

function! ParensRemoveSpacing()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')

  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<bs>\<right>\<bs>"
  endif
  
  if (prevChar == ' ' && afterChar == ' ')
    let prev = col('.') - 2
    let after = col('.') + 1
    let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
    let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
    if (prevChar == '"' && afterChar == '"') ||
  \    (prevChar == "'" && afterChar == "'") ||
  \    (prevChar == "(" && afterChar == ")") ||
  \    (prevChar == "{" && afterChar == "}") ||
  \    (prevChar == "[" && afterChar == "]")
      return "\<bs>\<right>\<bs>"
    endif
  endif
  
  return "\<bs>"
endfunction

inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap ' ''<left>
inoremap " ""<left>

let curly = "}"
inoremap <expr> } CheckNextParens(curly)

let bracket = "]"
inoremap <expr> ] CheckNextParens(bracket)

let parens = ")"
inoremap <expr> ) CheckNextParens(parens)

let quote = "'"
inoremap <expr> ' CheckNextQuote(quote)

let dquote = '"'
inoremap <expr> " CheckNextQuote(dquote)

let bticks = '`'
inoremap <expr> ` CheckNextQuote(bticks)

function CheckNextQuote(c)
  let after = col('.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  
  if (afterChar == a:c)
    return "\<right>"
  endif
  if (afterChar == ' ' || afterChar == '' || afterChar == ')' || afterChar== '}' || afterChar == ']')
    return a:c . a:c . "\<left>"
  endif
  if (afterChar != a:c)
    let bticks = '`'
    let dquote = '"'
    let quote = "'"
    if(afterChar == dquote || afterChar == quote || afterChar == bticks)
      return a:c . a:c . "\<left>"
    endif
  endif
  return a:c
endfunction

function CheckNextParens(c)
  let after = col('.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (afterChar == a:c)

    return "\<right>"
  endif
  return a:c
endfunction

"" function to run code
function Run()
  let bufType = &filetype
  if bufType == "python"
    execute "!python3 %"
  elseif bufType == "javascript"
    execute "!node %"
  elseif bufType == "typescript"
    execute "!ts-node %"
  elseif bufType == "go"
    execute "!go run %"
  elseif bufType == "rust"
    execute "!cargo run"
  elseif bufType == "c"
    execute "!gcc % -o %<"
    execute "!./%<"
  elseif bufType == "cpp"
    execute "!g++ % -o %<"
    execute "!./%<"
  elseif bufType == "java"
    execute "!javac %"
    execute "!java %<"
  elseif bufType == "php"
    execute "!php %"
  elseif bufType == "ruby"
    execute "!ruby %"
  elseif bufType == "html"
    execute "!firefox %"
  elseif bufType == "lua"
    execute "!lua %"
  elseif bufType == "elixir"
    execute "!elixir %"
  elseif bufType == "erlang"
    execute "!erl %"
  elseif bufType == "haskell"
    execute "!runh"
  elseif bufType == "make"
    execute "!make -f %"
  else 
    execute "!echo 'This is not a programming language'"
  endif
endfunction
