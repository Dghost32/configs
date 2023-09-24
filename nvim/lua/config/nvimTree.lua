local M = {}

function M.setup()
  local nvim_tree = require "nvim-tree"
  nvim_tree.setup {}
end

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

return M
