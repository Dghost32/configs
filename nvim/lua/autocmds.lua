-- this is needed to make the underline work
vim.api.nvim_create_autocmd('ColorScheme', {
  command = [[highlight DiagnosticUnderlineError gui=undercurl]],
  desc = "undercurl errors"
})

-- this is needed to make the underline work
vim.api.nvim_create_autocmd('ColorScheme', {
  command = [[highlight DiagnosticUnderlineWarn gui=undercurl]],
  desc = "undercurl warnings"
})

-- show diagnostics menu on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  command =
  'lua vim.diagnostic.open_float({win_opts = {border = "rounded", focusable = false, title = "Diagnostics", position = "bottomleft"}})',
  desc = "show diagnostics menu on cursor hold"
})

-- run LspZeroFormat on save
--vim.api.nvim_create_autocmd("BufWritePre", {
--command = 'LspZeroFormat',
--desc = "format on save"
--})

vim.api.nvim_create_autocmd('BufReadPre', {
  command = [[lua require('gitsigns').attach()]],
  desc = "attach gitsigns to a buffer when it is created"
})
