return {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme ayu-mirage]])
    end,
  },
  -- { "olimorris/onedarkpro.nvim", lazy = false, priority = 1000 },
  --"arzg/vim-colors-xcode",
  --"rebelot/kanagawa.nvim",
  --"catppuccin/nvim"
}
