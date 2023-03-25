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

-- [[ NvimTree ]]
map('n', '<leader>e', ':NvimTreeToggle<CR>')

-- [[ Window navigation ]]
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- [[ LSP ]]
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

-- [[ COQ ]]
map('i', '<Esc>', "pumvisible() ? '<C-e><Esc>' : '<Esc>'", { expr = true, silent = true }) -- exit menu
map('i', '<BS>', "pumvisible() ? '<C-e><BS>' : '<BS>'", { expr = true, silent = true }) -- use backspace in insert mode
map('i', '<C-l>', "pumvisible() ? (complete_info().selected == -1 ? '<C-e><CR>' : '<C-y>') : '<CR>'", { expr = true, silent = true }) -- confirm
map('i', '<C-j>', "pumvisible() ? '<C-n>' : '<Tab>'", { expr = true, silent = true }) -- go down 
map('i', '<C-j>', "pumvisible() ? '<C-p>' : '<BS>'", { expr = true, silent = true }) -- go up 
