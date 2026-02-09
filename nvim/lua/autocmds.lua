--[[ autocmds.lua ]]

-- Undercurl for diagnostics
vim.api.nvim_create_autocmd("ColorScheme", {
  command = [[highlight DiagnosticUnderlineError gui=undercurl]],
  desc = "Undercurl errors",
})

vim.api.nvim_create_autocmd("ColorScheme", {
  command = [[highlight DiagnosticUnderlineWarn gui=undercurl]],
  desc = "Undercurl warnings",
})

-- Highlight on yank (from kickstart.nvim)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
  desc = "Highlight on yank",
})
