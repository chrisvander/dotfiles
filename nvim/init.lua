-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		vim.lsp.buf.format({
			async = true,
			filter = function(client)
				return client.name ~= "tsserver"
			end,
		})
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	pattern = { "*" },
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set defaults
vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.fillchars = { eob = " ", vert = " ", fold = " " }
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.inccommand = "split"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmatch = true
vim.opt.title = true
vim.opt.timeoutlen = 200
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.wildmenu = true
vim.opt.syntax = "on"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.g.astro_typescript = "enable"
--vim.g.copilot_assume_mapped = true
--vim.g.copilot_no_tab_map = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup({ import = "plugins" })
