return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require('lsp-zero.settings').preset({})
    end
  },
  -- cmp
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'lsp-zero.nvim',
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      require('lsp-zero.cmp').extend()
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()
      cmp.setup({
        behavior = cmp.ConfirmBehavior.Replace,
        preselect = 'item',
        experimental = {
          ghost_text = true,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect',
          behavior = cmp.ConfirmBehavior.Replace,
          preselect = cmp.PreselectMode.None
        },
        sources = {
          { name = 'copilot', keyword_length = 0, group_index = 2 },
          { name = 'nvim_lsp' },
          { name = 'path', },
          { name = 'buffer',  keyword_length = 2 },
          { name = 'luasnip', keyword_length = 2 },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,
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
        mapping = {
          ["<C-s>"] = cmp.mapping.complete(),
          ["<C-k>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ['<C-e>'] = cmp.mapping.abort(),
        }
      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile', 'InsertEnter' },
    dependencies = {
      'lsp-zero.nvim',

      -- Mason
      'mason.nvim',
      { 'williamboman/mason-lspconfig.nvim', config = true },
      "jay-babu/mason-null-ls.nvim", -- Optional

      -- Navic
      "nvim-navic",

      -- Languages
      "wuelnerdotexe/vim-astro",
      "jxnblk/vim-mdx-js",
      "prisma/vim-prisma",

      -- Null-LS
      "jose-elias-alvarez/null-ls.nvim", -- Optional
    },
    config = function()
      local lsp = require('lsp-zero').preset({})
      local navic = require("nvim-navic")

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        if client.server_capabilities.documentSymbolProvider and client.name ~= "astro" and client.name ~= "mdx" then
          navic.attach(client, bufnr)
        end
      end)

      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                'vim',
                'require'
              },
            },
          }
        }
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
        automatic_installation = false,
        automatic_setup = false,
      })

      lsp.setup()

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
}
