require('lualine').setup {
  options = {
    global_status = true,
    disabled_filetypes = { 'NvimTree', 'vista', 'OverseerList' }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = { },
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_x = { 'overseer'},
    lualine_y = { 'filetype' },
    lualine_z = {'location'}
  },
  tabline = {
  },
  winbar = {
    lualine_a = {{'tabs', mode = 2}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {{
      'windows',

      filetype_names = {
        TelescopePrompt = 'Telescope',
        NvimTree = 'Filetree',
        dashboard = 'Dashboard',
        fzf = 'FZF',
        vista = 'Vista'
      },
      disabled_buftypes = { 'vista', 'prompt', 'OverseerList' },
    }},
    lualine_z = {}
  },
  extensions = { 'fzf', 'nvim-tree', 'toggleterm' }
}
