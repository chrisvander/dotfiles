return {
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = true
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = true,
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = false,
        -- auto_trigger = true,
        -- keymap = {
        --   accept = "<C-k>",
        --   accept_line = "<C-l>",
        --   accept_word = "<C-h>",
        --   next = "<C-.>",
        --   prev = "<C-,>",
        -- },
      },
    }
  }
}
