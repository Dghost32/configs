local M = {}

function M.setup()
  local noice = require "noice"
  noice.setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    notify = {
      enabled = false
    },
  })
end

return M
