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
  use { 'morhetz/gruvbox' }                         -- colorscheme
  use { 'catppuccin/nvim' } -- colorscheme

  -- [[ Copilot ]]
  use { 'github/copilot.vim' }                       -- copilot

  -- [[ LSP ]]
  use { 'neovim/nvim-lspconfig' }                    -- collection of configurations for built-in LSP client
  use "williamboman/mason.nvim"                      -- easy install of LSP servers
  use "williamboman/mason-lspconfig.nvim"            -- easy install of LSP servers
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        require("lspsaga").setup({})
    end,
    requires = {
        {"nvim-tree/nvim-web-devicons"},
        --Please make sure you install markdown and markdown_inline parser
        {"nvim-treesitter/nvim-treesitter"}
    }
  })

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

  -- [[ Testing ]]
  use { 'vim-test/vim-test' }                       -- testing

  -- [[ Autopairs ]]
  use { 'windwp/nvim-autopairs' }                   -- autopairs

  -- [[ CURSORLINE ]]
  use { 'yamatsum/nvim-cursorline' }                -- Highlight words and lines on the cursor for Neovim

  -- [[ BarBar ]]
  use { 'romgrk/barbar.nvim' }                      -- bufferline

  -- [[ Terminal ]]
  use { "akinsho/toggleterm.nvim", tag = '*' }

  -- [[ UltiSnips ]]
  use { 'SirVer/ultisnips' }                        -- snippets
  use { 'honza/vim-snippets' }                      -- snippets

  -- [[ IDE ]]
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end } -- fzf
  use 'junegunn/fzf.vim'                                              -- fzf
  use {'mg979/vim-visual-multi', branch = 'master'}                   -- multiple cursors
  use { 'easymotion/vim-easymotion' }                                -- easymotion
  use { 'preservim/nerdcommenter' }                                  -- comment
  use { 'tpope/vim-surround' }                                       -- surround
  use { 'karb94/neoscroll.nvim' }                                    -- smooth scroll
  use {
  'prettier/vim-prettier',
  config = function()
    vim.cmd("silent !yarn install --frozen-lockfile --production")
  end
  }

  -- [[ Git ]]
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- git
  --use { 'sindrets/diffview.nvim' }                  -- git
  
end)
