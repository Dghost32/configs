local M = {}

function M.setup()
  local tsconfig = require 'nvim-treesitter.configs'

  tsconfig.setup {
    sync_install = false,
    auto_install = false,
    autotag = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
end

return M
