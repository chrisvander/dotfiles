return {
	"jackMort/ChatGPT.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = true,
	opts = {
		keymaps = {
			submit = "<Enter>",
		},
	},
	keys = {
		{ "<C-b>", "<cmd>ChatGPT<cr>", { silent = true } },
		{ "<C-b>", "<cmd>ChatGPTRunCustomCodeAction<cr>", mode = "v", { silent = true } },
		{ "gb", "<cmd>ChatGPTEditWithInstructions<cr>", mode = { "n", "v" }, { silent = true } },
	},
}
