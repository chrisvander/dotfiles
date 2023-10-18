return {
	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	-- most comment keybindings set here
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	-- add documentation generation
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter",
		opts = {
			input_after_comment = true,
		},
		config = true,
		cmd = "Neogen",
		keys = { {
			"gcd",
			"<cmd>Neogen<CR>",
			desc = "Toggle documentation generation",
		} },
	},
	{
		"stevearc/overseer.nvim",
		opts = {
			strategy = { "toggleterm" },
		},
		config = true,
		keys = {
			{ "<leader>r", "<cmd>OverseerRun<CR>", desc = "Start task" },
			{ "<leader>o", "<cmd>OverseerTaskAction<CR>", desc = "Open running task(s)" },
		},
	},
	{
		"folke/which-key.nvim",
		config = true,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
		keys = {
			{
				"<leader>p",
				function()
					require("persistence").load()
				end,
				desc = "Restore session",
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		config = true,
		keys = {
			{ "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle zen mode" },
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = { render = "compact", timeout = 3000 },
		lazy = false,
		keys = { { "<leader>n", "<cmd>Telescope notify<cr>", desc = "Open notifications" } },
	},
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-notify",
		},
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = { enabled = false },
				signature = { enabled = false },
			},
			-- you can enable a preset for easier configuration
			presets = {
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
}
