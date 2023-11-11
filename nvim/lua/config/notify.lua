local M = {}

local icons = require "utils.icons"

function M.setup()
  local notify = require "notify"
  notify.setup {};
  vim.notify = notify
end

return M
