return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap" },
	config = true,
	keys = { {
		"<leader>d",
		function()
			require("dapui").toggle()
		end,
		{ silent = true },
	} },
}
