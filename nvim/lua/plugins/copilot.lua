return {
	"zbirenbaum/copilot.lua",
	--dependencies = {
	--"hrsh7th/nvim-cmp",
	--"zbirenbaum/copilot-cmp",
	--},
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			--suggestion = { enabled = false },
			--panel = { enabled = false },
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<C-k>",
					accept_line = "<C-l>",
					accept_word = "<C-h>",
					next = "<C-.>",
					prev = "<C-,>",
				},
			},
		})
		--require('copilot_cmp').setup()
	end,
}
