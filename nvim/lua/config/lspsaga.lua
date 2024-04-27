local M = {}

function M.setup()
  local lspsaga = require("lspsaga")
  lspsaga.setup()

  local keymap = vim.keymap.set

  keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")              -- LSP finder - Find the symbol's definition
  keymap("n", "gr", "<cmd>Lspsaga rename<CR>")                  -- Rename all occurrences of the hovered word for the entire file
  keymap("n", "pd", "<cmd>Lspsaga peek_definition<CR>")         -- Peek definition
  keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")         -- Go to definition
  keymap("n", "pt", "<cmd>Lspsaga peek_type_definition<CR>")    -- Peek type definition
  keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")    -- Go to type definition
  keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")          -- Toggle outline
  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")                -- Hover Doc
  keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>") -- Floating terminal
end

return M
