return {
	{ "ggandor/lightspeed.nvim", event = "VeryLazy" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = true,
		opts = {
			show_current_context = true,
			show_current_context_start = true,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"dockerfile",
					"go",
					"graphql",
					"html",
					"javascript",
					"json",
					"python",
					"regex",
					"rust",
					"toml",
					"tsx",
					"typescript",
					"yaml",
				},
				highlight = {
					enable = false,
				},
			})
		end,
	},
	"kkharji/sqlite.lua",
	"scrooloose/nerdcommenter",
	{
		"mrjones2014/dash.nvim",
		build = "make install",
		keys = { { "<silent>gh", "<cmd>DashWord<CR>" } },
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter",
		opts = {
			input_after_comment = true,
		},
		config = true,
		cmd = "Neogen",
		keys = { {
			"<leader>n",
			"<cmd>Neogen<CR>",
		} },
	},
	{
		"stevearc/overseer.nvim",
		opts = {
			strategy = { "toggleterm", open_on_start = false, close_on_exit = true },
		},
		config = true,
		keys = {
			{ "<leader>r", "<cmd>OverseerRun<CR>" },
			{ "<leader>oo", "<cmd>OverseerToggle right<CR>" },
		},
	},
	{
		"folke/which-key.nvim",
		config = true,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = true,
	},
}
