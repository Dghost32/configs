--[[ keymaps.lua — all keymaps with desc for which-key ]]
local map = vim.keymap.set

-- [[ Save ]]
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })
map("v", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })

-- [[ Quit ]]
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("i", "<C-q>", "<Esc><cmd>q<CR>", { desc = "Quit" })
map("v", "<C-q>", "<Esc><cmd>q<CR>", { desc = "Quit" })

-- [[ Run code ]]
map("n", "<leader>x", "<cmd>RunCode<CR>", { desc = "Run code" })

-- [[ Split resize ]]
map("n", "<leader><Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
map("n", "<leader><Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })

-- [[ Move lines (Alt+j/k like VSCode) ]]
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- [[ Tabs ]]
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Only this tab" })
map("n", "<leader>tm", "<cmd>tabmove<CR>", { desc = "Move tab" })
map("n", "<leader>h", "<cmd>tabprevious<CR>", { desc = "Prev tab" })
map("n", "<leader>l", "<cmd>tabnext<CR>", { desc = "Next tab" })

-- [[ Better movement ]]
map("n", "<C-k>", "10k", { desc = "Move 10 lines up" })
map("n", "<C-j>", "10j", { desc = "Move 10 lines down" })

-- [[ Keeping it centered ]]
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Prev search centered" })
map("n", "J", "mzJ`z", { desc = "Join lines centered" })

-- [[ Select all ]]
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- [[ Better indenting ]]
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- [[ Quick semicolon ]]
map("n", ",", "$a;<Esc>", { desc = "Append semicolon", silent = true })

-- [[ Window navigation ]]
map("n", "<C-h>", "<C-w>h", { desc = "Window left", silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "Window right", silent = true })
