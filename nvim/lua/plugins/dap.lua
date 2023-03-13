return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"williamboman/mason.nvim",
		{
			"jay-babu/mason-nvim-dap.nvim",
			config = function()
				require("mason-nvim-dap").setup()
				require("mason-nvim-dap").setup_handlers()
			end,
		},
	},
	config = true,
	keys = { {
		"<leader><C-d>",
		function()
			require("dapui").toggle()
		end,
		{ silent = true },
	} },
}
