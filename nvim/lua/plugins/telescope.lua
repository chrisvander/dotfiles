local function project_files()
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files({ show_untracked = true })
  else
    require "telescope.builtin".find_files({})
  end
end

return {
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    event = "BufRead",
    keys = { { "<leader>t", "<cmd>TodoTelescope<CR>", desc = "Open todo list" } },
    cmd = "TodoTelescope",
  },
  {
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
      { "<leader>f", project_files,                                  desc = "Open file picker" },
      { "<leader>F", "<cmd>Telescope file_browser<CR>",              desc = "Open file browser" },
      { "<leader>/", "<cmd>Telescope live_grep<CR>",                 desc = "Global search in workspace folder" },
      { "<leader>b", "<cmd>Telescope buffers<CR>",                   desc = "Open buffer picker" },
      { "<leader>j", "<cmd>Telescope jumplist<CR>",                  desc = "Open jumplist" },
      { "<leader>s", vim.lsp.buf.document_symbol,                    desc = "Open symbols" },
      { "<leader>S", vim.lsp.buf.workspace_symbol,                   desc = "Open workspace symbols" },
      { "<leader>z", "<cmd>Telescope zoxide list<CR>",               desc = "Open workspace folder picker" },
      { "gd",        "<cmd>Telescope lsp_definitions theme=ivy<CR>", { silent = true } },
      { "gu",        "<cmd>Telescope lsp_references theme=ivy<CR>",  { silent = true } },
    },
  }
}
