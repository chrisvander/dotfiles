return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-j>]],
			direction = "vertical",
			size = function()
				return vim.o.columns * 0.4
			end,
		})

		local function set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<C-t>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.api.nvim_create_autocmd({ "TermOpen" }, {
			pattern = { "term://*" },
			callback = set_terminal_keymaps,
		})
		vim.keymap.set("t", "<C-S-j>", "<Cmd>ToggleTermToggleAll<CR>")
		vim.keymap.set("n", "<C-S-j>", "<Cmd>ToggleTermToggleAll<CR>")
		vim.keymap.set("i", "<C-S-j>", "<Cmd>ToggleTermToggleAll<CR>")

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
		local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })
		local k9s = Terminal:new({ cmd = "k9s", hidden = true, direction = "float" })

		function _Lazygit_toggle()
			lazygit:toggle()
		end

		function _Lazydocker_toggle()
			lazydocker:toggle()
		end

		function _K9s_toggle()
			k9s:toggle()
		end

		vim.keymap.set("n", "<leader>og", "<cmd>lua _Lazygit_toggle()<cr>")
		vim.keymap.set("n", "<leader>od", "<cmd>lua _Lazydocker_toggle()<cr>")
		vim.keymap.set("n", "<leader>ok", "<cmd>lua _K9s_toggle()<cr>")
	end,
}
