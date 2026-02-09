vim.api.nvim_create_autocmd('ColorScheme', {
  command = [[highlight DiagnosticUnderlineError gui=undercurl]],
  desc = "undercurl errors"
})

vim.api.nvim_create_autocmd('ColorScheme', {
  command = [[highlight DiagnosticUnderlineWarn gui=undercurl]],
  desc = "undercurl warnings"
})

vim.api.nvim_create_autocmd('BufReadPre', {
  command = [[lua require('gitsigns').attach()]],
  desc = "attach gitsigns to a buffer when it is created"
})

-- run LspZeroFormat on save
--vim.api.nvim_create_autocmd("BufWritePre", {
--command = 'LspZeroFormat',
--desc = "format on save"
--})
