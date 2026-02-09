-- [[ LEADER ]] (must be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ LAZY.NVIM BOOTSTRAP ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- [[ PLUGINS ]]
require("lazy").setup({
	{ import = "plugins" },
}, {
	install = { colorscheme = { "catppuccin-mocha" } },
	checker = { enabled = false },
	change_detection = { notify = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- [[ CORE CONFIG ]]
require("opts")
require("keymaps")
require("autocmds")
