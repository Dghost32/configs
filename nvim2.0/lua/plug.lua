return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- [[ Tree ]]
  use {                                              -- filesystem navigation
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'        -- filesystem icons
  }

  -- [[ Theme ]]
  use { 'mhinz/vim-startify' }                       -- start screen
  use { 'DanilaMihailov/beacon.nvim' }               -- cursor jump
  use {
    'nvim-lualine/lualine.nvim',                     -- statusline
    requires = {'kyazdani42/nvim-web-devicons',
                opt = true}
  }
  use { 'Mofiqul/dracula.nvim' }
  use { 'catppuccin/nvim' } -- colorscheme

  -- [[ Copilot ]]
  use { 'github/copilot.vim' }                       -- copilot

  -- [[ LSP ]]
  use { 'neovim/nvim-lspconfig' }                    -- collection of configurations for built-in LSP client
  use "williamboman/mason.nvim"                      -- easy install of LSP servers
  use "williamboman/mason-lspconfig.nvim"            -- easy install of LSP servers

  -- [[ Completion ]]
  use { 'ms-jpq/coq_nvim' }
  use { 'ms-jpq/coq.artifacts' }
  use { 'ms-jpq/coq.thirdparty' }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- syntax highlighting

  -- [[ Breadcrumbs ]]
  use({
    "utilyre/barbecue.nvim",
  })
  use { 'SmiteshP/nvim-navic' }                     -- breadcrumbs 

  -- [[ TELESCOPE ]]
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
end)
