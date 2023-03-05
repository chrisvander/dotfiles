local theme = function()
	local colors = {
		darkgray = "#16161d",
		gray = "#727169",
		innerbg = nil,
		outerbg = "#16161D",
		normal = "#7e9cd8",
		insert = "#98bb6c",
		visual = "#ffa066",
		replace = "#e46876",
		command = "#e6c384",
	}
	return {
		inactive = {
			a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerbg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		visual = {
			a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerbg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		replace = {
			a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerbg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		normal = {
			a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerbg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		insert = {
			a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerbg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		command = {
			a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerbg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
	}
end

local function get_location()
	return require("nvim-navic").get_location()
end

local function is_available()
	return require("nvim-navic").is_available()
end

return {
	{ "SmiteshP/nvim-navic", lazy = true, config = true, opts = { highlight = true } },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-navic", "arkav/lualine-lsp-progress" },
		config = true,
		opts = {
			options = {
				global_status = true,
				theme = theme(),
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { right = "", left = "" }, right_padding = 2 },
				},
				lualine_b = { "branch" },
				lualine_c = { "lsp_progress", "diff", "diagnostics" },
				lualine_x = { "overseer" },

				lualine_y = { "filetype" },
				lualine_z = { { "location", separator = { right = "", left = "" }, left_padding = 2 } },
			},
			tabline = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{ get_location, cond = is_available },
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {
					{
						"windows",
						filetype_names = {
							TelescopePrompt = "Telescope",
							NvimTree = "Filetree",
							dashboard = "Dashboard",
							fzf = "FZF",
							vista = "Vista",
						},
						disabled_buftypes = { "vista", "prompt", "OverseerList" },
						separator = { right = "", left = "" },
						left_padding = 2,
					},
				},
			},
			extensions = { "fzf", "nvim-tree", "toggleterm" },
		},
	},
}
