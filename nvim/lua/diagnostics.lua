vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
    focusable = false,
    title = "Diagnostics",
    position = "bottomleft",
  },
})