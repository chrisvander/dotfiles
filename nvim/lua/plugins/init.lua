return {
  { "tpope/vim-surround",      event = "VeryLazy" },
  { "stevearc/dressing.nvim",  event = "VeryLazy" },
  { "jbyuki/instant.nvim",     event = "VeryLazy" },
  { "ggandor/lightspeed.nvim", event = "VeryLazy" },
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = "<C-c>",
        block = "<C-b>",
      },
      opleader = {
        line = '<C-c>',
        block = '<C-b>',
      },
      mappings = { extra = false },
    },
    config = true,
    keys = { { "<C-c>", desc = "Toggle line comment" }, { "<C-b>", desc = "Toggle block comment" } },
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter",
    opts = {
      input_after_comment = true,
    },
    config = true,
    cmd = "Neogen",
    keys = { {
      "<leader>n",
      "<cmd>Neogen<CR>",
    } },
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      strategy = { "toggleterm" },
    },
    config = true,
    keys = {
      { "<leader>r", "<cmd>OverseerRun<CR>",        desc = "Start task" },
      { "<leader>o", "<cmd>OverseerTaskAction<CR>", desc = "Open running task(s)" },
    },
  },
  {
    "folke/which-key.nvim",
    config = true,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    keys = {
      { "<leader>p", function() require("persistence").load() end, desc = "Restore session" },
    },
  },
  {
    "folke/zen-mode.nvim",
    config = true,
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle zen mode" },
    }
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      { "rcarriga/nvim-notify", opts = { render = "compact", top_down = false } },
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = false },
        signature = { enabled = false },
      },
      -- you can enable a preset for easier configuration
      presets = {
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    },
  },

}
