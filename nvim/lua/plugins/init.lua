return {
  { "ggandor/lightspeed.nvim", event = "VeryLazy" },
  { "tpope/vim-surround",      event = "VeryLazy" },
  { "stevearc/dressing.nvim",  event = "VeryLazy" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "dockerfile",
          "go",
          "graphql",
          "html",
          "javascript",
          "json",
          "python",
          "regex",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "yaml",
        },
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "lsp-zero.nvim",
    },
    event = "BufRead",
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local language_servers = require("lspconfig").util.available_servers()
      for _, ls in ipairs(language_servers) do
        require("lspconfig")[ls].setup({
          capabilities = capabilities,
        })
      end
      require("ufo").setup()
    end,
    keys = {
      {
        "n",
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
      {
        "n",
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
      },
    },
  },
  "kkharji/sqlite.lua",
  "scrooloose/nerdcommenter",
  {
    "mrjones2014/dash.nvim",
    build = "make install",
    keys = { { "<silent>gh", "<cmd>DashWord<CR>" } },
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
      strategy = { "toggleterm", open_on_start = false, close_on_exit = true },
    },
    config = true,
    keys = {
      { "<leader>r", "<cmd>OverseerRun<CR>" },
      { "<leader>o", "<cmd>OverseerTaskAction<CR>" },
    },
  },
  {
    "folke/which-key.nvim",
    config = true,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      { "rcarriga/nvim-notify", opts = { render = "compact", stages = "static" } },
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
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
  },
}
