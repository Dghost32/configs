local base_dir = vim.env.LUNARVIM_BASE_DIR
    or (function()
      local init_path = debug.getinfo(1, "S").source
      return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
    end)()

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:append(base_dir)
end


require("lvim.bootstrap"):init(base_dir)

require("lvim.config"):load()

local plugins = require "lvim.plugins"

require("lvim.plugin-loader").load { plugins, lvim.plugins }

require("lvim.core.theme").setup()

local Log = require "lvim.core.log"
Log:debug "Starting LunarVim"

local commands = require "lvim.core.commands"
commands.load(commands.defaults)

-- NO SÉ DÓNDE PONERLO (:
require('luasnip').filetype_extend("javascript", { "javascriptreact" })
require('luasnip').filetype_extend("javascript", { "html" })

-- FORMAT ON SAVE
lvim.format_on_save = true

require('code_runner').setup({
  -- put here the commands by filetype
  filetype = {
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = "python3 -u",
    typescript = "ts-node $fileName",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
    javascript = "node $fileName",
    php = "php $fileName",
  },
})

-- RANGE SELECTION
-- vim.api.nvim_set_keymap("n", "<C-y>", "<Plug>(coc-range-select)", { silent = true })
-- vim.api.nvim_set_keymap("x", "<C-y>", "<Plug>(coc-range-select)", { silent = true })
