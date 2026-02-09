return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>t", group = "Tab/Test" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>n", group = "Tree" },
        { "<leader>b", group = "Buffer" },
        { "<leader>a", group = "AI" },
        { "<leader>o", group = "Outline" },
        { "<leader>p", group = "Session" },
        { "<leader>h", group = "Tab prev" },
        { "<leader>l", group = "Tab next" },
      },
    },
  },
}
