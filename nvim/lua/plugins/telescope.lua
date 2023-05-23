local function project_files()
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files({ show_untracked = true })
  else
    require "telescope.builtin".find_files({})
  end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "gbrlsnchs/telescope-lsp-handlers.nvim",
    'jvgrootveld/telescope-zoxide',
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-notify",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("lsp_handlers")
    require("telescope").load_extension("notify")
    require("telescope").load_extension("zoxide")
    require("telescope").load_extension("file_browser")
    require("telescope").setup({
      defaults = {
        hidden = true,
        initial_mode = "insert",
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        lsp_handlers = {
          code_action = {
            telescope = require("telescope.themes").get_dropdown({}),
          },
        },
      },
    })
  end,
  cmd = "Telescope",
  keys = {
    { "<leader>f/", "<cmd>Telescope<CR>" },
    { "<leader>fF", "<cmd>Telescope find_files<CR>" },
    { "<leader>ff", project_files },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>" },
    { "<leader>fb", "<cmd>Telescope file_browser<CR>" },
    { "<leader>fv", "<cmd>Telescope buffers<CR>" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>" },
    { "<leader>fz", "<cmd>Telescope zoxide list<CR>" },
    { "gd",         "<cmd>Telescope lsp_definitions theme=ivy<CR>", { silent = true } },
    { "gu",         "<cmd>Telescope lsp_references theme=ivy<CR>",  { silent = true } },
  },
}
