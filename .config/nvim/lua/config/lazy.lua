--Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

-- Put lazy into runtimepath
vim.opt.runtimepath:prepend(lazypath)

-- Set mapleaders before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- 🔥 Set transparency BEFORE loading tokyonight
vim.g.tokyonight_transparent = true

-- Setup lazy
require("lazy").setup({
	spec = {
		-- 🌙 ###Tokyonight theme
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			config = function()

			vim.cmd.colorscheme("tokyonight")
			
			-- Hard override (after colorscheme is set)
    vim.cmd([[
      hi Normal guibg=NONE ctermbg=NONE
      hi NormalNC guibg=NONE ctermbg=NONE
      hi NormalFloat guibg=NONE ctermbg=NONE
      hi FloatBorder guibg=NONE ctermbg=NONE
      hi Pmenu guibg=NONE
    ]])
			end,
		},

		-- 🧠### Minimal statusline
		{
			"echasnovski/mini.nvim",
			enabled = true ,
			config = function()
				local statusline = require("mini.statusline")
				statusline.setup({ use_icons = true })
			end,
		},
	},
})

