local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"

  local function header()
    return require("utils.logos")["random"]
  end

  dashboard.section.header.val = header()

  dashboard.section.buttons.val = {
    dashboard.button("e", " New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("c", " Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("t", " Open tree explorer", ":NvimTreeToggle<CR>"),
    dashboard.button("f", "󰈞 Find file", ":Telescope find_files <CR>"),
    dashboard.button("h", "󰎧 Recently opened files", ":Telescope oldfiles <CR>"),
    dashboard.button("p", "󰕾 Find word", ":Telescope live_grep <CR>"),
    dashboard.button("P", " Find project", ":Telescope projects<CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    -- Number of plugins
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y %H:%M:%S"
    local plugins_text = " 🏔️ "
        .. total_plugins
        .. " plugins"
        .. "   "
        .. vim.version().major
        .. "."
        .. vim.version().minor
        .. "."
        .. vim.version().patch
        .. "    "
        .. datetime

    -- Quote
    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

local function open_alpha()
  vim.cmd [[
    autocmd User DashboardReady ++once nested
      silent! lua require'alpha'.start()
  ]]
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_alpha })

return M
