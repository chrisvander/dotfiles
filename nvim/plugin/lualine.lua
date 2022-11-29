require('lualine').setup {
  options = {
    global_status = true,
    disabled_filetypes = { 'filetree', 'vista' }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = { },
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_x = {},
    lualine_y = { 'filetype' },
    lualine_z = {'location'}
  },
  tabline = {
    lualine_a = {{'tabs', mode = 2}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {{
      'windows',

      filetype_names = {
        TelescopePrompt = 'Telescope',
        dashboard = 'Dashboard',
        fzf = 'FZF',
        vista = 'Vista'
      },
      disabled_buftypes = { 'vista', 'prompt' },
    }},
    lualine_z = {}
  },
  extensions = { 'fzf', 'nvim-tree', 'toggleterm' }
}
