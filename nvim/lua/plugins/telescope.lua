return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })
      telescope.load_extension("fzf")
    end,
    keys = {
      -- Files & buffers (existing)
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>ob", "<cmd>Telescope buffers<CR>", desc = "Open buffers" },
      { "<leader>ss", "<cmd>Telescope spell_suggest<CR>", desc = "Spell suggest" },
      -- Replace fzf Ag
      { "<leader>ag", "<cmd>Telescope live_grep<CR>", desc = "Grep (was Ag)" },
      -- New
      { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Search keymaps" },
      -- Git (existing)
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
    },
  },

  -- Frecency (recent files ranked by frequency + recency)
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("frecency")
    end,
    keys = {
      { "<leader>fr", "<cmd>Telescope frecency<CR>", desc = "Recent files (frecency)" },
    },
  },
}
