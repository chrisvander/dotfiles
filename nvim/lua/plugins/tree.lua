return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  filters = {
    custom = { ".git", "node_modules", ".cache", "*.lock" },
  },
  git = {
    ignore = false,
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>" },
  },
  config = function()
    require('nvim-tree').setup()
  end
}
