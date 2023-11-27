local M = {}

function M.setup()
  local nvim_tree = require "nvim-tree"
  nvim_tree.setup({
    update_cwd = true,
    git = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    view = {
      side = "left",
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    filters = {
      dotfiles = false,
      git_ignored = false
    },
    diagnostics = {
      enable = true,
    },
  })
end

local function open_tree()
  vim.cmd [[
    autocmd User DashboardReady ++once nested
      silent! NvimTreeOpen
  ]]
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_tree })

return M
