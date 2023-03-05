return {
	"jackMort/ChatGPT.nvim",
	lazy = false,
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = true,
	keys = {
		{ "<C-b>", "<cmd>ChatGPT<cr>", { silent = true } },
		{ "<C-b>", "<cmd>ChatGPTRunCustomCodeAction<cr>", mode = "v", { silent = true } },
		{ "gb", "<cmd>ChatGPTEditWithInstructions<cr>", mode = { "n", "v" }, { silent = true } },
	},
}
