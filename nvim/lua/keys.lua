--[[ keys.lua ]]
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- [[ Keymaps ]]

-- [[ Leader ]]
vim.g.mapleader = " "

-- [[ Save ]]
map('n', '<leader>w', ':w<CR>')
map('i', '<C-s>', '<Esc>:w<CR>')
map('v', '<C-s>', '<Esc>:w<CR>')

-- [[ Quit ]]
map('n', '<leader>q', ':q<CR>')
map('i', '<C-q>', '<Esc>:q<CR>')
map('v', '<C-q>', '<Esc>:q<CR>')

-- [[ LSP ]]
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

-- [[ Telescope - Files & Buffers ]]
map('n', '<leader>ob', '<cmd>Telescope buffers<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>ss', '<cmd>Telescope spell_suggest<CR>')

-- [[ GIT ]]
-- [[ Telescope - Git ]]
map('n', '<leader>gs', '<cmd>Telescope git_status<CR>')
map('n', '<leader>gc', '<cmd>Telescope git_commits<CR>')
map('n', '<leader>gb', '<cmd>Telescope git_branches<CR>')
-- [[  Gitsigns ]]
map('n', '<leader>gR', '<cmd>Gitsigns reset_buffer<CR>')
map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>')
map('n', 'gb', '<cmd>Gitsigns blame_line<CR>', { silent = true })
map('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<CR>')

-- [[ COQ - Completition menu movement ]]
map('i', '<Esc>', "pumvisible() ? '<C-e><Esc>' : '<Esc>'", { expr = true, silent = true }) -- exit menu
map('i', '<BS>', "pumvisible() ? '<C-e><BS>' : '<BS>'", { expr = true, silent = true }) -- use backspace in insert mode
map('i', '<C-l>', "pumvisible() ? (complete_info().selected == -1 ? '<C-e><CR>' : '<C-y>') : '<CR>'", { expr = true, silent = true }) -- confirm
map('i', '<C-j>', "pumvisible() ? '<C-n>' : '<Tab>'", { expr = true, silent = true }) -- go down with tab
map('i', '<C-u>', "pumvisible() ? '<C-p>' : '<BS>'", { expr = true, silent = true }) -- go up 

-- [[ Testing ]] 
map('n', '<leader>tt', ':TestNearest<CR>')
map('n', '<leader>tf', ':TestFile<CR>')
map('n', '<leader>ts', ':TestSuite<CR>')

-- [[ Split Resize ]]
map('n', '<leader><Up>', ':resize -2<CR>')
map('n', '<leader><Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- [[ Move current line / block with Alt-j/k like vscode. ]]
map('n', '<A-j>', ':m .+1<CR>==')
map('n', '<A-k>', ':m .-2<CR>==')
map('v', '<A-j>', ":m '>+1<CR>gv=gv") -- move selected line / block of text in visual mode 
map('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- [[ Tabs ]] 
map('n', '<leader>tn', ':tabnew<CR>')
map('n', '<leader>tc', ':tabclose<CR>')
map('n', '<leader>to', ':tabonly<CR>')
map('n', '<leader>tm', ':tabmove<CR>')
map('n', '<leader>h', ':tabprevious<CR>')
map('n', '<leader>l', ':tabnext<CR>')

-- [[ Better movement ]]
map('n', '<C-k>', '10k')
map('n', '<C-j>', '10j')

-- [[ Keeping it Centered ]]
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

-- [[ Better indenting ]]
map('v', '<', '<gv')
map('v', '>', '>gv')

-- [[ Quick SEMICOLON (;) ]] 
map('n', ',', '$a;<esc>', { noremap = true, silent = true })

-- [[ NvimTree ]]
map('n', '<leader>nt', ':NvimTreeToggle<CR>') -- toggle nvim tree
map('n', '<leader>nr', ':NvimTreeRefresh<CR>') -- refresh nvim tree
map('n', '<leader>nf', ':NvimTreeFindFile<CR>') -- find file in nvim tree
map('n', '<leader>e', ':NvimTreeFocus<CR>') -- find file in nvim tree

-- [[ TMUX ]]
--map('n', '<C-h>', ':TmuxNavigateLeft<CR>')
--map('n', '<C-l>', ':TmuxNavigateRight<CR>')
--map('n', '<leader><C-j>', ':TmuxNavigateDown<CR>')

-- [[ Window navigation ]]
map('n', '<C-h>', '<C-w>h', { silent = true })
map('n', '<C-l>', '<C-w>l', { silent = true })
