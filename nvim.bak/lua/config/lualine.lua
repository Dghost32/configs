local M = {}

function M.setup()
  local lualine = require "lualine"
  lualine.setup({
    options = {
      theme = 'catppuccin',
      component_separators = '|',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        { 'mode' },
      },
      lualine_b = { 'branch' },
      lualine_c = { 'fileformat' },
      lualine_y = { 'progress' },
      lualine_z = {
        { 'filetype' },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  })
end

return M
