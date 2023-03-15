local inactive = {
	black = "#000000",
	white = "#ffffff",
	fg = "#696969",
	bg_2 = "#202728",
	index = "#61afef",
}

local active = vim.tbl_extend("force", inactive, {
	fg = "#abb2bf",
	bg_2 = "#282c34",
	index = "#d19a66",
})

local render = function(f)
	f.make_tabs(function(info)
		local colors = info.current and active or inactive

		f.add({
			" " .. info.index .. " ",
			fg = colors.index,
		})

		f.set_colors({ fg = colors.fg, bg = nil })

		f.add(" ")
		if info.filename then
			f.add(info.modified and "+")
			f.add(info.filename)
			f.add({
				" " .. f.icon(info.filename),
				fg = info.current and f.icon_color(info.filename) or nil,
			})
		else
			f.add(info.modified and "[+]" or "[-]")
		end
		f.add(" ")
		f.add(" ")
	end)

	f.add_spacer()
end

return {
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-web-devicons",
		},
		opts = { attach_navic = false },
	},
	{
		"rafcamlet/tabline-framework.nvim",
		config = function()
			require("tabline_framework").setup({
				render = render,
			})
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local theme = require("lualine.themes.auto")
			theme.normal.c.bg = nil
			require("lualine").setup({
				options = {
					theme = theme,
					global_status = true,
					--component_separators = { left = "", right = "" },
					--section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { "searchcount", "diff" },
					lualine_x = { "diagnostics", "overseer", "progress" },
					lualine_y = { "filetype" },
					lualine_z = { "location" },
				},
				extensions = { "fzf", "nvim-tree", "toggleterm" },
			})
		end,
	},
}
