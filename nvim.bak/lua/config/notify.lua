local M = {}

function M.setup()
  local notify = require "notify"

  notify.setup({
    render = "wrapped-compact",
    timeout = 1000,
    max_width = 70,
  })

  -- vim.notify = notify
end

return M
