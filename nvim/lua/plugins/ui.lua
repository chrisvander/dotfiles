return {
	{
		"petertriho/nvim-scrollbar",
		config = true,
		opts = {
			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
				"noice",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = true,
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 0,
			},
		},
		keys = {
			{ "<leader>D", "<cmd>Gitsigns diffthis<CR>" },
		},
	},
}
