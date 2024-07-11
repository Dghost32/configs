local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  'lervag/vimtex', -- LaTex

  {                -- [[ Startup screen ]]
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end
  },

  'nvim-tree/nvim-web-devicons',

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

  { -- [[ STATUSLINE - bottom ]]
    'nvim-lualine/lualine.nvim',
    config = function()
      require("config.lualine").setup()
    end
  },

  -- [[ Themes ]]
  { 'catppuccin/nvim' },
  { "lunarvim/lunar.nvim" },
  { "folke/tokyonight.nvim" },
  { 'oxfist/night-owl.nvim' },
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, },

  { -- [[ Better cmd && src ui ]]
    'folke/noice.nvim',
    dependencies = { { 'MunifTanjim/nui.nvim' }, { 'rcarriga/nvim-notify' } },
    config = function()
      require("config.noice").setup()
    end
  },

  { -- [[ Treesitter - syntax highlighting ]]
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require("config.ts").setup()
    end
  },

  { -- [[ Breadcrumbs ]]
    "utilyre/barbecue.nvim",
    config = function()
      require("config.barbecue").setup()
    end
  },

  { -- [[ TELESCOPE ]]
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' } },
    config = function()
      require("config.telescope").setup()
    end
  },

  { 'vim-test/vim-test' }, -- [[ Testing ]]

  {
    'windwp/nvim-ts-autotag',
    config = function()
      require("config.nvim-ts-autotag").setup()
    end
  },

  {                        -- [[ Autopairs ]]
    'windwp/nvim-autopairs',
    config = function()
      require("config.autopairs").setup()
    end
  },

  { -- [[ CURSORLINE  -- Highlight words and lines on the cursor for Neovim ]]
    'yamatsum/nvim-cursorline',
    config = function()
      require("config.cursorline").setup()
    end
  },

  -- [[ BarBar ]]
  { 'romgrk/barbar.nvim',                 dependencies = { 'SmiteshP/nvim-navic' } }, -- bufferline

  -- -- [[ indent line ]]
  { 'lukas-reineke/indent-blankline.nvim' }, -- indent line

  -- [[ Terminal ]]
  {
    "akinsho/toggleterm.nvim",
    version = '*',
    config = function()
      require("config.toggleterm").setup()
    end
  },

  -- -- [[ Todo ]]
  {
    "folke/todo-comments.nvim",
    config = function()
      require("config.todocomments").setup()
    end
  },

  -- -- [[ UltiSnips ]]
  -- {'SirVer/ultisnips'}, -- snippets
  -- {'honza/vim-snippets'}, -- snippets

  -- -- [[ IDE ]]
  { 'SmiteshP/nvim-navic' }, -- breadcrumbs
  {
    'junegunn/fzf',
    build = function()
      vim.fn['fzf#install']()
    end
  },
  -- fzf
  'junegunn/fzf.vim',
  {
    'mg979/vim-visual-multi',
    branch = 'master'
  },                               -- multiple cursors
  { 'easymotion/vim-easymotion' }, -- easymotion
  {
    "chaoren/vim-wordmotion",
    lazy = true,
    fn = { "<Plug>WordMotion_w" }
  },
  -- { 'preservim/nerdcommenter' }, -- comment
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options hereby
      toggler = {
        line = "gcc",
        block = "gCc",
      }
    },
    lazy = false,
  },
  { 'tpope/vim-surround' }, -- surround
  {                         -- smooth scroll
    'karb94/neoscroll.nvim',
    config = function()
      require("config.neoscroll").setup()
    end
  },
  {
    "michaelb/sniprun",
    build = "bash install.sh"
  },
  { -- code runner
    'CRAG666/code_runner.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require("config.codeRunner").setup()
    end
  },
  { -- color utils
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end
  },
  { "sbdchd/neoformat" },
  { 'github/copilot.vim' }, -- [[ Copilot ]]

  -- [[ Trouble nvim ]]
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  },

  -- [[ Git ]]
  { -- [[ gitsigns -- line diff ]]
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("config.gitsigns").setup()
    end
  },
  { -- [[ Neogit ]]
    "TimUntersberger/neogit",
    cmd = "Neogit",
    module = { "neogit" },
    config = function()
      require("config.neogit").setup()
    end
  },

  { -- [[ Markdown ]]
    "iamcco/markdown-preview.nvim",
    lazy = true,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    dependencies = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" }
  },

  -- -- [[ LSP ]]
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {               -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
        config = function()
          require("config.mason").setup()
        end
      }, { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      -- Autocompletion
      {
        "hrsh7th/nvim-cmp",
        -- dependencies = {
        --   "quangnguyen30192/cmp-nvim-ultisnips",
        --   config = function()
        --     -- optional call to setup (see customization section)
        --     -- require("cmp_nvim_ultisnips").setup {}
        --   end
        -- }
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lua' },        -- Snippets
      { 'L3MON4D3/LuaSnip' },            -- Required
      { 'rafamadriz/friendly-snippets' } -- Optional
    },
    config = function()
      require("config.lsp").setup()
    end
  },                          -- end of lspzero

  { 'onsails/lspkind.nvim' }, -- lsp icons
  {                           -- lsp saga
    'glepnir/lspsaga.nvim',
    config = function()
      require("config.lspsaga").setup()
    end
  },
})
