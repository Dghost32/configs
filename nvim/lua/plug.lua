return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'lervag/vimtex' --LaTex

  use {               -- [[ Startup screen ]]
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end,
  }

  use { -- [[ Tree ]]
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("config.nvimTree").setup()
    end,
  }

  use { -- [[ STATUSLINE - bottom ]]
    'nvim-lualine/lualine.nvim',
    config = function()
      require("config.lualine").setup()
    end,
  }

  -- [[ Themes ]]
  use { 'catppuccin/nvim' }
  use { "lunarvim/lunar.nvim" }
  use { "folke/tokyonight.nvim" }
  use { 'oxfist/night-owl.nvim' }

  use { -- [[ Better cmd && src ui ]]
    'folke/noice.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' },
      { 'rcarriga/nvim-notify' }
    }, config = function()
    require("config.noice").setup()
  end, }


  use { -- [[ Treesitter - syntax highlighting ]]
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require("config.ts").setup()
    end,
  }

  use({ -- [[ Breadcrumbs ]]
    "utilyre/barbecue.nvim",
    config = function()
      require("config.barbecue").setup()
    end
  })

  use { -- [[ TELESCOPE ]]
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = function()
      require("config.telescope").setup()
    end,
  }


  use { 'vim-test/vim-test' } -- [[ Testing ]]


  use { -- [[ Autopairs ]]
    'windwp/nvim-autopairs',
    config = function()
      require("config.autopairs").setup()
    end
  }

  use { -- [[ CURSORLINE  -- Highlight words and lines on the cursor for Neovim ]]
    'yamatsum/nvim-cursorline',
    config = function()
      require("config.cursorline").setup()
    end
  }

  -- [[ BarBar ]]
  use { 'romgrk/barbar.nvim' } -- bufferline

  -- [[ indent line ]]
  use { 'lukas-reineke/indent-blankline.nvim' } -- indent line

  -- [[ Terminal ]]
  use { "akinsho/toggleterm.nvim", tag = '*',
    config = function()
      require("config.toggleterm").setup()
    end
  }

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
  use {                                                                -- smooth scroll
    'karb94/neoscroll.nvim',
    config = function()
      require("config.neoscroll").setup()
    end,
  }
  use {
    "michaelb/sniprun",
    run = "bash install.sh"
  }
  use { -- code runner
    'CRAG666/code_runner.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("config.codeRunner").setup()
    end,
  }
  use { -- color utils
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end,
  }
  use { "sbdchd/neoformat" }
  use { 'github/copilot.vim' } -- [[ Copilot ]]


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
  use { -- [[ gitsigns -- line diff ]]
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("config.gitsigns").setup()
    end,
  }
  use { -- [[ Neogit ]]
    "TimUntersberger/neogit",
    cmd = "Neogit",
    module = { "neogit" },
    config = function()
      require("config.neogit").setup()
    end,
  }


  use { -- [[ Markdown ]]
    "iamcco/markdown-preview.nvim",
    opt = true,
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  }

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
        config = function()
          require("config.mason").setup()
        end
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      -- Autocompletion
      {
        "hrsh7th/nvim-cmp",
        requires = {
          "quangnguyen30192/cmp-nvim-ultisnips",
          config = function()
            -- optional call to setup (see customization section)
            require("cmp_nvim_ultisnips").setup {}
          end,
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
    },
    config = function()
      require("config.lsp").setup()
    end,
  }                              -- end of lspzero

  use { 'onsails/lspkind.nvim' } -- lsp icons
  use {                          -- lsp saga
    'glepnir/lspsaga.nvim',
    config = function()
      require("config.lspsaga").setup()
    end,
  }
end)
