return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "lsp-zero.nvim", "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",

			-- Navic
			"nvim-navic",

			-- Languages
			"wuelnerdotexe/vim-astro",
			"jxnblk/vim-mdx-js",
			"prisma/vim-prisma",

			-- Formatting
			{
				"stevearc/conform.nvim",
				opts = {
					formatters_by_ft = {
						lua = { "stylua" },
						python = { "isort", "black" },
						json = { { "prettierd", "prettier" } },
						javascript = { { "eslint_d", "eslint" }, { "prettierd", "prettier" } },
						typescript = { { "eslint_d", "eslint" }, { "prettierd", "prettier" } },
						typescriptreact = { { "eslint_d", "eslint" }, { "prettierd", "prettier" } },
						javascriptreact = { { "eslint_d", "eslint" }, { "prettierd", "prettier" } },
					},
					format_on_save = {
						timeout_ms = 500,
						lsp_fallback = true,
					},
				},
				config = true,
			},
		},
		lazy = true,
		config = function()
			local lsp_zero = require("lsp-zero")
			local navic = require("nvim-navic")

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				if
					client.server_capabilities.documentSymbolProvider
					and client.name ~= "astro"
					and client.name ~= "mdx"
				then
					navic.attach(client, bufnr)
				end
			end)

			require("mason").setup({})
			require("mason-lspconfig").setup({
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
					tsserver = function()
						local tsserver_opts = {
							settings = {
								typescript = {
									preferences = {
										importModuleSpecifierPreference = "non-relative",
									},
								},
							},
						}
						require("lspconfig").tsserver.setup(tsserver_opts)
					end,
				},
			})

			-- Filter out empty messages from hover
			local prev_hover = vim.lsp.handlers["textDocument/hover"]
			vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
				config = config or {}
				config.focus_id = ctx.method
				if not (result and result.contents) then
					return
				end
				if type(result.contents) == "table" and vim.tbl_isempty(result.contents) then
					return
				end
				return prev_hover(_, result, ctx, config)
			end

			local cmp = require("cmp")
			local cmp_format = require("lsp-zero").cmp_format()

			cmp.setup({
				formatting = cmp_format,
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
			})
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
					require("conform").format()
				end,
				{ silent = true },
			},
		},
	},
}
