local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
	-- formatting
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("Format", {clear = true}),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end
			})
	end
end

-- Enable language server
nvim_lsp.lua_ls.setup {
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = {'vim'},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
}
