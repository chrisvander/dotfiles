return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{
			"utilyre/barbecue.nvim",
			dependencies = {
				"SmiteshP/nvim-navic",
				"nvim-web-devicons",
			},
			opts = { attach_navic = false },
		},
		"catppuccin/nvim",
		"arkav/lualine-lsp-progress",
	},
	opts = {
		options = {
			global_status = true,
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { right = "", left = "" }, right_padding = 2 },
			},
			lualine_b = { "branch" },
			lualine_c = { "diff", "diagnostics" },
			lualine_x = { "lsp_progress", "overseer" },
			lualine_y = { "filetype" },
			lualine_z = { { "location", separator = { right = "", left = "" }, left_padding = 2 } },
		},
		extensions = { "fzf", "nvim-tree", "toggleterm" },
	},
}
