local M = {}

function M.setup()
  local nvim_tree = require "nvim-tree"
  nvim_tree.setup({})
end

local function open_tree()
  vim.cmd [[
    autocmd User DashboardReady ++once nested
      silent! NvimTreeOpen
  ]]
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_tree })

return M
