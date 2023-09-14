return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',

    -- Navic
    "nvim-navic",

    -- Languages
    "wuelnerdotexe/vim-astro",
    "jxnblk/vim-mdx-js",
    "prisma/vim-prisma",

    -- Null-LS
    'jay-babu/mason-null-ls.nvim',
    'jose-elias-alvarez/null-ls.nvim'
  },
  lazy = true,
  config = function()
    local lsp_zero = require('lsp-zero')
    local navic = require('nvim-navic')

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
      if client.server_capabilities.documentSymbolProvider and client.name ~= "astro" and client.name ~= "mdx" then
        navic.attach(client, bufnr)
      end
    end)

    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        "tsserver",
        "eslint",
        "tailwindcss",
      },
      handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
        end,
        tsserver = function()
          local tsserver_opts = {
            settings = {
              typescript = {
                preferences = {
                  importModuleSpecifierPreference = 'non-relative',
                }
              }
            }
          }
          require('lspconfig').tsserver.setup(tsserver_opts)
        end,
      }
    })

    -- Filter out empty messages from hover
    local prev_hover = vim.lsp.handlers['textDocument/hover']
    vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
      config = config or {}
      config.focus_id = ctx.method
      if not (result and result.contents) then
        return
      end
      if vim.tbl_isempty(result.contents) then
        return
      end
      return prev_hover(_, result, ctx, config)
    end

    local cmp = require('cmp')
    local cmp_format = require('lsp-zero').cmp_format()

    cmp.setup({
      formatting = cmp_format,
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
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
      })
    })

    local null_ls = require("null-ls")
    local null_opts = lsp_zero.build_options("null-ls", {})

    null_ls.setup({
      on_attach = null_opts.on_attach,
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.code_actions.eslint_d,
      },
    })

    require("mason-null-ls").setup({
      ensure_installed = { "prettier" },
      automatic_installation = false,
      automatic_setup = false,
    })
  end,
  keys = {
    { "K",  vim.lsp.buf.hover },
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
