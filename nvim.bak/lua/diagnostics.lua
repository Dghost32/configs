vim.diagnostic.get(0, {
  severity = { vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
    vim.diagnostic.severity.HINT,
    vim.diagnostic.severity.ERROR,
  }
})

vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = true,
    border = "rounded",
    focusable = false,
    title = "Diagnostics 🚀",
    position = "bottomleft",
  },
})

-- show diagnostics menu on cursor hold
-- vim.api.nvim_create_autocmd("CursorHold", {
--   command =
--   'lua vim.diagnostic.open_float({win_opts = {border = "rounded", focusable = false, title = "Diagnostics", position = "bottomleft"}})',
--   desc = "show diagnostics menu on cursor hold"
-- })
