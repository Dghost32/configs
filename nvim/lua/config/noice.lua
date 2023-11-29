local M = {}

function M.setup()
  local noice = require "noice"
  noice.setup({
    notify = {
      enabled = false
    },
  })
end

return M
