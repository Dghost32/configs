return {
  -- Neo-tree (file explorer)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
      { "<leader>nt", "<cmd>Neotree toggle left<CR>", desc = "Toggle tree" },
      { "<leader>nr", "<cmd>Neotree refresh left<CR>", desc = "Refresh tree" },
      { "<leader>nf", "<cmd>Neotree reveal left<CR>", desc = "Reveal in tree" },
      { "<leader>e", "<cmd>Neotree focus left<CR>", desc = "Focus tree" },
    },
  },

  -- Toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 50,
      open_mapping = [[<C-t>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = false,
      direction = "vertical",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    },
  },

  -- Code runner
  {
    "CRAG666/code_runner.nvim",
    cmd = "RunCode",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      filetype = {
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        python = "python3 -u",
        typescript = "ts-node $fileName",
        javascript = "node $fileName",
        rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
        cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        html = "firefox $fileName",
        default = "echo 'No command for filetype: $filetype' && exit 1",
      },
    },
  },

  -- Conform (formatter, replaces neoformat + LspZeroFormat)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        python = { "black" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    keys = {
      {
        "<leader>z",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format file",
      },
      {
        "<leader>g",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format file (alt)",
      },
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Persistence (session management — Zed-like "open recent")
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>ps", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
      { "<leader>pd", function() require("persistence").stop() end, desc = "Don't save session" },
    },
  },

  -- Color utils
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    opts = {},
  },

  -- Markview (markdown rendering)
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = "MarkdownPreview",
    build = function() vim.fn["mkdp#util#install"]() end,
    dependencies = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  },

  -- Vim-test
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite" },
    keys = {
      { "<leader>tt", "<cmd>TestNearest<CR>", desc = "Test nearest" },
      { "<leader>tf", "<cmd>TestFile<CR>", desc = "Test file" },
      { "<leader>ts", "<cmd>TestSuite<CR>", desc = "Test suite" },
    },
  },

  -- LaTeX
  { "lervag/vimtex", ft = "tex" },
}
