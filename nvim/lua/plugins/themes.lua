return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	"olimorris/onedarkpro.nvim",
	"arzg/vim-colors-xcode",
	"rebelot/kanagawa.nvim",
	"Shatur/neovim-ayu",
}
