return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-file-browser.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"gbrlsnchs/telescope-lsp-handlers.nvim",
		"fannheyward/telescope-coc.nvim",
	},
	config = function()
		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("lsp_handlers")
		require("telescope").load_extension("coc")
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git",
					".cache",
					"*.lock",
				},
			},
			extensions = {
				lsp_handlers = {
					code_action = {
						telescope = require("telescope.themes").get_dropdown({}),
					},
				},
				file_browser = {
					hidden = true,
					respect_gitignore = true,
					depth = false,
				},
				coc = {
					theme = "ivy",
					prefer_locations = true,
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = false,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})
	end,
	keys = {
		{ "<leader>ft", "<cmd>Telescope<CR>"  },
		{ "<leader>ff", "<cmd>Telescope find_files<CR>" },
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>" },
		{ "<leader>fb", "<cmd>Telescope file_browser<CR>" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>" },
		{ "gd", "<cmd>Telescope lsp_definitions theme=ivy<CR>", { silent = true } },
		{ "gu", "<cmd>Telescope lsp_references theme=ivy<CR>", { silent = true } },
		{ "gt", "<cmd>Telescope lsp_type_definitions theme=ivy<CR>", { silent = true } },
	},
}
