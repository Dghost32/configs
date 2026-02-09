local M = {}

function M.setup()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- automatically setup all installed language servers
  local servers = { 'tsserver' }
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(capabilities)
  end

  local lsp = require('lsp-zero').preset({
    name = 'minimal',
    --set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = false,
  })

  -- (Optional) Configure lua language server for neovim
  lsp.nvim_workspace()

  lsp.setup()

  -- Enable diagnostics
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Enable underline, use default values
      underline = true, -- underline
      virtual_text = { prefix = '', spacing = 4 },
      -- Use a function to dynamically turn signs off
      -- and on, using buffer local variables
      signs = function(_, bufnr)
        return vim.b[bufnr].show_signs == true
      end,
      -- Disable a feature
      update_in_insert = false,
    }
  )
end

return M
