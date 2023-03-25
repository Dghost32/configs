-- Setup language servers.
local lspconfig = require('lspconfig')
local coq = require("coq")

-- automatically setup all installed language servers
local servers = { 'pyright', 'tsserver', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities())
end

vim.cmd('COQnow -s')


