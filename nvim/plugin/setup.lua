require('nvim-tree').setup({
  open_on_setup = true,
  filters = {
    dotfiles = true,
  },
  git = {
    ignore = false,
  }
})
require('telescope').setup({
  extensions = {
    lsp_handlers = {
      code_action = {
        telescope = require('telescope.themes').get_dropdown({}),
      },
    },
  }
})
require('telescope').load_extension('file_browser')
require('telescope').load_extension('fzf')
require('telescope').load_extension('lsp_handlers')
require('colorizer').setup()
require('neoscroll').setup({ easing_function = "cubic" })
require('which-key').setup()
require('neogen').setup({
  input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
})
require('overseer').setup({
  strategy = "toggleterm",
})
require("octo").setup()

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
})

lsp.nvim_workspace({
  library = vim.api.nvim_get_runtime_file('', true)
})
lsp.set_preferences({
  set_lsp_keymaps = { omit = { '<F2>', 'gi', 'gl', 'gr', 'go', 'gd' } }
})
lsp.setup()

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup({
  on_attach = null_opts.on_attach,
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.eslint_d
  }
})
