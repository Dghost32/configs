return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- [[ Tree ]]
  use {                                       -- filesystem navigation
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons' -- filesystem icons
  }

  -- [[ Theme ]]
  use { 'mhinz/vim-startify' }         -- start screen
  use { 'DanilaMihailov/beacon.nvim' } -- cursor jump
  use {
    'nvim-lualine/lualine.nvim',       -- statusline
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    }
  }
  use { 'Mofiqul/dracula.nvim' }
  use { 'morhetz/gruvbox' } -- colorscheme
  use { 'catppuccin/nvim' } -- colorscheme

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
  }
  use { 'onsails/lspkind.nvim' } -- lsp icons
  use { "glepnir/lspsaga.nvim" } -- lsp saga

  -- [[ Treesitter ]]
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- syntax highlighting

  -- [[ Breadcrumbs ]]
  use({
    "utilyre/barbecue.nvim",
  })

  use { 'SmiteshP/nvim-navic' } -- breadcrumbs

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

  -- [[ UltiSnips ]]
  use { 'SirVer/ultisnips' }   -- snippets
  use { 'honza/vim-snippets' } -- snippets

  -- [[ IDE ]]
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end } -- fzf
  use 'junegunn/fzf.vim'                                               -- fzf
  use { 'mg979/vim-visual-multi', branch = 'master' }                  -- multiple cursors
  use { 'easymotion/vim-easymotion' }                                  -- easymotion
  use { 'preservim/nerdcommenter' }                                    -- comment
  use { 'tpope/vim-surround' }                                         -- surround
  use { 'karb94/neoscroll.nvim' }                                      -- smooth scroll
  use {
    'prettier/vim-prettier',
    config = function()
      vim.cmd("silent !yarn install --frozen-lockfile --production")
    end
  }
  use 'ray-x/web-tools.nvim' -- web tools
  use {
    "michaelb/sniprun",
    run = "bash install.sh"
  }
  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' } -- code runner

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
end)
