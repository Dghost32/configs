require("lspsaga").setup({})

local keymap = vim.keymap.set

-- LSP finder - Find the symbol's definition
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Rename all occurrences of the hovered word for the entire file
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

-- Peek definition
keymap("n", "pd", "<cmd>Lspsaga peek_definition<CR>")

-- Go to definition
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

-- Peek type definition
keymap("n", "pt", "<cmd>Lspsaga peek_type_definition<CR>")

-- Go to type definition
keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")

-- Toggle outline
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
--keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- If you want to keep the hover window in the top right hand corner,
keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

-- Floating terminal
keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
