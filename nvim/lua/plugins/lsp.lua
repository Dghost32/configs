return {
  -- Native LSP (replaces lsp-zero)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "ts_ls", "pyright", "html", "cssls",
          "jsonls", "bashls", "tailwindcss",
        },
        automatic_enable = true,
      })

      -- Default capabilities for all servers (cmp integration)
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Lua special config (for neovim development)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
            format = {
              defaultConfig = {
                indent_size = "2",
              },
            },
          },
        },
      })

      -- Diagnostics config
      vim.diagnostic.config({
        underline = true,
        virtual_text = { prefix = "", spacing = 4 },
        signs = true,
        update_in_insert = false,
      })

      -- LspAttach autocmd (kickstart pattern) — buffer-local keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
          end
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        end,
      })
    end,
  },

  -- Lspsaga (enhanced LSP UI)
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    opts = {},
    keys = {
      { "gh", "<cmd>Lspsaga lsp_finder<CR>", desc = "LSP finder" },
      { "gr", "<cmd>Lspsaga rename<CR>", desc = "Rename symbol" },
      { "pd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
      { "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to definition" },
      { "pt", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek type definition" },
      { "gt", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Go to type definition" },
      { "<leader>o", "<cmd>Lspsaga outline<CR>", desc = "Toggle outline" },
      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover doc" },
      { "<A-d>", "<cmd>Lspsaga term_toggle<CR>", desc = "Float terminal (saga)", mode = { "n", "t" } },
      { "<leader>xn", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" },
      { "<leader>xp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev diagnostic" },
      { "<leader>hh", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Line diagnostics" },
      { "<leader>xx", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Buffer diagnostics" },
    },
  },

  -- Trouble (diagnostics list)
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document diagnostics" },
    },
  },

  -- LSP kind icons
  { "onsails/lspkind.nvim", lazy = true },
}
