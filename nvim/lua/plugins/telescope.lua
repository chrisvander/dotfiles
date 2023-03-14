return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		"gbrlsnchs/telescope-lsp-handlers.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("lsp_handlers")
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
				coc = {
					theme = "ivy",
					prefer_locations = true,
				},
			},
		})
	end,
	keys = {
		{ "<leader>ft", "<cmd>Telescope<CR>" },
		{ "<leader>ff", "<cmd>Telescope find_files<CR>" },
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>" },
		{ "<leader>fb", "<cmd>Telescope file_browser<CR>" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>" },
		{ "gd", "<cmd>Telescope lsp_definitions theme=ivy<CR>", { silent = true } },
		{ "gu", "<cmd>Telescope lsp_references theme=ivy<CR>", { silent = true } },
		{ "<leader>lt", "<cmd>Telescope lsp_type_definitions theme=ivy<CR>", { silent = true } },
	},
}
