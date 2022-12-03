require('nvim-tree').setup()
require('telescope').setup({
  extensions = {
    coc = {
      prefer_locations = true
    }
  }
})
require('telescope').load_extension('file_browser')
require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')
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
