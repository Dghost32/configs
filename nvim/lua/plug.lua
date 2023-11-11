return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Startup screen
  use {
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end,
  }

  -- [[ Tree ]]
  use {                                        -- filesystem navigation
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons', -- filesystem icons
    config = function()
      require("config.nvimTree").setup()
    end,
  }

  -- [[ STATUSLINE ]]
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require("config.lualine").setup()
    end,
  }

  -- [[ Theme ]]
  use { 'catppuccin/nvim' }
  use { "lunarvim/lunar.nvim" }
  use { "folke/tokyonight.nvim" }
  use { 'oxfist/night-owl.nvim' }

  -- [[ Copilot ]]
  use { 'github/copilot.vim' } -- copilot

  -- [[ LSP ]]
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      {
        "hrsh7th/nvim-cmp",
        requires = {
          "quangnguyen30192/cmp-nvim-ultisnips",
          config = function()
            -- optional call to setup (see customization section)
            require("cmp_nvim_ultisnips").setup {}
          end,
          -- If you want to enable filetype detection based on treesitter:
          -- requires = { "nvim-treesitter/nvim-treesitter" },
        },
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'quangnguyen30192/cmp-nvim-ultisnips' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }                                       -- end of lspzero

  use { 'onsails/lspkind.nvim' }          -- lsp icons
  use { 'glepnir/lspsaga.nvim' }          -- lsp saga

  -- [[ Treesitter ]]
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- syntax highlighting

  -- [[ Breadcrumbs ]]
  use({
    "utilyre/barbecue.nvim",
  })

  -- [[ TELESCOPE ]]
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- [[ Testing ]]
  use { 'vim-test/vim-test' } -- testing

  -- [[ Autopairs ]]
  use { 'windwp/nvim-autopairs' } -- autopairs

  -- [[ CURSORLINE ]]
  use { 'yamatsum/nvim-cursorline' } -- Highlight words and lines on the cursor for Neovim

  -- [[ BarBar ]]
  use { 'romgrk/barbar.nvim' } -- bufferline

  -- [[ indent line ]]
  use { 'lukas-reineke/indent-blankline.nvim' } -- indent line

  -- [[ Terminal ]]
  use { "akinsho/toggleterm.nvim", tag = '*' }

  -- [[ Todo ]]
  use {
    "folke/todo-comments.nvim",
    config = function()
      require("config.todocomments").setup()
    end,
  }

  -- [[ UltiSnips ]]
  use { 'SirVer/ultisnips' }   -- snippets
  use { 'honza/vim-snippets' } -- snippets

  -- [[ IDE ]]
  use { 'SmiteshP/nvim-navic' }                                        -- breadcrumbs
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end } -- fzf
  use 'junegunn/fzf.vim'                                               -- fzf
  use { 'mg979/vim-visual-multi', branch = 'master' }                  -- multiple cursors
  use { 'easymotion/vim-easymotion' }                                  -- easymotion
  use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } }
  use { 'preservim/nerdcommenter' }                                    -- comment
  use { 'tpope/vim-surround' }                                         -- surround
  use { 'karb94/neoscroll.nvim' }                                      -- smooth scroll
  use {
    "michaelb/sniprun",
    run = "bash install.sh"
  }
  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' } -- code runner
  use {                                                                  -- color utils
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end,
  }


  -- [[ Trouble nvim ]]
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  }

  -- [[ Git ]]
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- git
  use {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    module = { "neogit" },
    config = function()
      require("config.neogit").setup()
    end,
  }

  -- [[ Markdown ]]
  use {
    "iamcco/markdown-preview.nvim",
    opt = true,
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  }
end)
