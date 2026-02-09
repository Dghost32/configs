return {
  -- Gitsigns (inline blame, signs, hunk preview)
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "│" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = true,
      linehl = false,
      word_diff = false,
      watch_gitdir = { follow_files = true },
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 5,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
    keys = {
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", desc = "Git reset buffer" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Git preview hunk" },
      { "gb", "<cmd>Gitsigns blame_line<CR>", desc = "Git blame line" },
    },
  },

  -- Neogit (magit-like git UI)
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
  },

  -- Diffview (Zed-like git compare view)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_mixed" },
      },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File git history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Branch git history" },
      { "<leader>gx", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
    },
  },
}
