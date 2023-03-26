require("toggleterm").setup({
  active = true,
  on_config_done = nil,
  size = 50,
  open_mapping = [[<c-t>]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = false,
  direction = "vertical",
  shell = vim.o.shell,
  close_on_exit = true,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
