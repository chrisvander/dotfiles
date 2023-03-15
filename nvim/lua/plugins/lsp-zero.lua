return {
	"VonHeikemen/lsp-zero.nvim",
	event = "BufReadPre",
	dependencies = {
		-- LSP Support
		"neovim/nvim-lspconfig", -- Required
		"williamboman/mason.nvim", -- Optional
		"williamboman/mason-lspconfig.nvim", -- Optional

		-- Null-LS
		"jose-elias-alvarez/null-ls.nvim", -- Optional
		"jay-babu/mason-null-ls.nvim", -- Optional

		-- Autocompletion
		"hrsh7th/nvim-cmp", -- Required
		"hrsh7th/cmp-nvim-lsp", -- Required
		"hrsh7th/cmp-buffer", -- Optional
		"hrsh7th/cmp-path", -- Optional
		"hrsh7th/cmp-cmdline", -- Optional
		"saadparwaiz1/cmp_luasnip", -- Optional
		"hrsh7th/cmp-nvim-lua", -- Optional
		"petertriho/cmp-git", -- Optional

		-- Extra languages
		"wuelnerdotexe/vim-astro",
		"jxnblk/vim-mdx-js",
		"prisma/vim-prisma",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets", -- Optional

		-- Status Line Connections
		"nvim-navic",
	},
	config = function()
		local lsp = require("lsp-zero")
		lsp.preset({
			name = "recommended",
			manage_nvim_cmp = true,
		})

		lsp.ensure_installed({
			"tsserver",
			"eslint",
			"tailwindcss",
		})

		lsp.nvim_workspace({
			library = vim.api.nvim_get_runtime_file("", true),
		})

		lsp.set_preferences({
			set_lsp_keymaps = { omit = { "<F2>", "gi", "gl", "gr", "go", "gd" } },
		})

		local navic = require("nvim-navic")

		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
		end

		lsp.on_attach(on_attach)

		local cmp = require("cmp")

		lsp.setup_nvim_cmp({
			sources = {
				--{ name = "copilot" },
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "buffer", keyword_length = 2 },
			},
			completion = {
				autocomplete = false,
			},
			sorting = {
				comparators = {
					--require("copilot_cmp.comparators").prioritize,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			preselect = cmp.PreselectMode.Item,
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		lsp.setup()

		local orig_handler = vim.lsp.handlers["textDocument/hover"]
		vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
			if not result or not result.contents or vim.tbl_isempty(result.contents) then
				return
			end
			return orig_handler(_, result, ctx, config)
		end

		local null_ls = require("null-ls")
		local null_opts = lsp.build_options("null-ls", {})

		null_ls.setup({
			on_attach = null_opts.on_attach,
			sources = {
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.code_actions.eslint_d,
			},
		})

		require("mason-null-ls").setup({
			ensure_installed = nil,
			automatic_installation = true,
			automatic_setup = true,
		})

		-- Required when `automatic_setup` is true
		require("mason-null-ls").setup_handlers()
	end,
	keys = {
		{ "K", vim.lsp.buf.hover },
		{ "ga", vim.lsp.buf.code_action, { silent = true } },
		{
			"gi",
			function()
				vim.diagnostic.open_float(nil, { focus = false })
			end,
			{ noremap = true, silent = true, mode = { "n", "x" } },
		},
		{ "gr", vim.lsp.buf.rename, { silent = true } },
		{
			"gf",
			function()
				vim.lsp.buf.format({
					filter = function(client)
						return client.name ~= "tsserver"
					end,
				})
			end,
			{ silent = true },
		},
	},
}
