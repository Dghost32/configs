return {
  -- Catppuccin theme (matches Zed editor)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = { enabled = false },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      integrations = {
        barbar = true,
        cmp = true,
        gitsigns = true,
        treesitter = true,
        neotree = true,
        noice = true,
        lsp_saga = true,
        native_lsp = { enabled = true },
        telescope = { enabled = true },
        which_key = true,
        indent_blankline = { enabled = true },
        mini = { enabled = true },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "fileformat" },
        lualine_y = { "progress" },
        lualine_z = { "filetype" },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
    },
  },

  -- Bufferline (barbar)
  {
    "romgrk/barbar.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = false,
      auto_hide = false,
      tabpages = true,
      clickable = true,
      focus_on_close = "left",
      highlight_inactive_file_icons = false,
      highlight_visible = true,
      icons = {
        filetype = { enabled = true },
        separator = { left = "▎", right = "▎" },
        close = { icon = "" },
        close_modified = { icon = "●" },
        pinned = { button = "󰐄" },
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false },
        },
      },
      icon_custom_colors = false,
      insert_at_end = false,
      maximum_padding = 1,
      minimum_padding = 1,
      maximum_length = 30,
      semantic_letters = true,
    },
    keys = {
      { "<A-,>", "<cmd>BufferPrevious<CR>", desc = "Buffer previous" },
      { "<A-.>", "<cmd>BufferNext<CR>", desc = "Buffer next" },
      { "<A-<>", "<cmd>BufferMovePrevious<CR>", desc = "Buffer move prev" },
      { "<A->>", "<cmd>BufferMoveNext<CR>", desc = "Buffer move next" },
      { "<A-1>", "<cmd>BufferGoto 1<CR>", desc = "Buffer goto 1" },
      { "<A-2>", "<cmd>BufferGoto 2<CR>", desc = "Buffer goto 2" },
      { "<A-3>", "<cmd>BufferGoto 3<CR>", desc = "Buffer goto 3" },
      { "<A-4>", "<cmd>BufferGoto 4<CR>", desc = "Buffer goto 4" },
      { "<A-5>", "<cmd>BufferGoto 5<CR>", desc = "Buffer goto 5" },
      { "<A-6>", "<cmd>BufferGoto 6<CR>", desc = "Buffer goto 6" },
      { "<A-7>", "<cmd>BufferGoto 7<CR>", desc = "Buffer goto 7" },
      { "<A-8>", "<cmd>BufferGoto 8<CR>", desc = "Buffer goto 8" },
      { "<A-9>", "<cmd>BufferGoto 9<CR>", desc = "Buffer goto 9" },
      { "<A-0>", "<cmd>BufferLast<CR>", desc = "Buffer last" },
      { "<A-p>", "<cmd>BufferPin<CR>", desc = "Buffer pin" },
      { "<A-c>", "<cmd>BufferClose<CR>", desc = "Buffer close" },
      { "<C-p>", "<cmd>BufferPick<CR>", desc = "Buffer pick" },
      { "<leader>bb", "<cmd>BufferOrderByBufferNumber<CR>", desc = "Order by number" },
      { "<leader>bd", "<cmd>BufferOrderByDirectory<CR>", desc = "Order by directory" },
      { "<leader>bl", "<cmd>BufferOrderByLanguage<CR>", desc = "Order by language" },
      { "<leader>bw", "<cmd>BufferOrderByWindowNumber<CR>", desc = "Order by window" },
    },
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = require("utils.logos")["random"]
      dashboard.section.buttons.val = {
        dashboard.button("e", " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("c", " Configuration", ":e $MYVIMRC <CR>"),
        dashboard.button("t", " Open tree explorer", ":Neotree toggle position=left<CR>"),
        dashboard.button("f", "󰈞 Find file", ":Telescope find_files <CR>"),
        dashboard.button("h", "󰎧 Recently opened files", ":Telescope oldfiles <CR>"),
        dashboard.button("r", "󰊄 Recent files (frecency)", ":Telescope frecency <CR>"),
        dashboard.button("p", "󰕾 Find word", ":Telescope live_grep <CR>"),
        dashboard.button("s", " Restore session", [[<cmd>lua require("persistence").load()<CR>]]),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }

      local function footer()
        local datetime = os.date("%d-%m-%Y %H:%M:%S")
        local lazy_stats = require("lazy").stats()
        local plugins_text = " " .. lazy_stats.loaded .. "/" .. lazy_stats.count .. " plugins"
          .. "   " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
          .. "    " .. datetime

        local ok, fortune = pcall(require, "alpha.fortune")
        local quote = ok and table.concat(fortune(), "\n") or ""
        return plugins_text .. "\n" .. quote
      end

      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "Constant"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Function"
      dashboard.section.buttons.opts.hl_shortcut = "Type"
      dashboard.opts.opts.noautocmd = true

      alpha.setup(dashboard.opts)
    end,
  },

  -- Noice (better cmd/search UI)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      notify = { enabled = false },
      presets = {
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Breadcrumbs
  {
    "utilyre/barbecue.nvim",
    event = "BufReadPre",
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    opts = {},
  },

  -- Cursorline + cursorword highlighting
  {
    "yamatsum/nvim-cursorline",
    event = "BufReadPre",
    opts = {
      cursorline = { enable = true, timeout = 1000, number = false },
      cursorword = { enable = true, min_length = 3, hl = { underline = true } },
    },
  },
}
