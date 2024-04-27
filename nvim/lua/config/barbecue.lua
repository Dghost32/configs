local M = {}

function M.setup()
  local barbecue = require('barbecue')

  barbecue.setup {
    theme = 'catppuccin',
  }
end

return M
