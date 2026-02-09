return {
	-- Copilot (Lua-native, replaces copilot.vim)
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		opts = {
			panel = { enabled = false },
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept_word = "<C-l>",
					accept_line = "<C-j>",
				},
			},
		},
		keys = {
			{
				"<C-c>",
				function()
					require("copilot.suggestion").accept()
				end,
				desc = "Copilot accept",
				mode = "i",
			},
			{
				"<C-x>",
				function()
					require("copilot.suggestion").dismiss()
				end,
				desc = "Copilot dismiss",
				mode = "i",
			},
			{
				"<C-\\>",
				function()
					require("copilot.panel").open()
				end,
				desc = "Copilot panel",
				mode = { "n", "i" },
			},
		},
	},

	-- CodeCompanion (AI chat/assist — supports Claude, Copilot, and more)
	{
		"olimorris/codecompanion.nvim",
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			strategies = {
				chat = { adapter = "copilot" },
				inline = { adapter = "copilot" },
			},
			display = {
				chat = {
					icons = { tool_success = "󰸞 " },
					fold_context = true,
				},
			},
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "AI actions", mode = { "n", "v" } },
			{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", desc = "AI chat toggle", mode = { "n", "v" } },
			{ "<leader>ai", "<cmd>CodeCompanion<CR>", desc = "AI inline", mode = { "n", "v" } },
		},
		init = function()
			vim.cmd([[cab cc CodeCompanion]])
		end,
	},
}
