return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    opts = {
      toggler = { line = "gcc", block = "gCc" },
    },
  },

  -- Surround
  {
    "tpope/vim-surround",
    event = "BufReadPre",
  },

  -- Easymotion
  {
    "easymotion/vim-easymotion",
    event = "BufReadPre",
  },

  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufReadPre",
  },

  -- Smooth scroll
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPre",
    opts = {},
  },
}
