return {
  {
    "jackMort/ChatGPT.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = true,
    opts = {
      keymaps = {
        submit = "<Enter>",
      },
    },
    keys = {
      { "<C-b>", "<cmd>ChatGPT<cr>",                     { silent = true } },
      { "<C-b>", "<cmd>ChatGPTRunCustomCodeAction<cr>",  mode = "v",          { silent = true } },
      { "gb",    "<cmd>ChatGPTEditWithInstructions<cr>", mode = { "n", "v" }, { silent = true } },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = true,
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-k>",
          accept_line = "<C-l>",
          accept_word = "<C-h>",
          next = "<C-.>",
          prev = "<C-,>",
        },
      },
    }
  }
}
