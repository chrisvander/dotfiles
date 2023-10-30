return {
  -- theme
  { "Shatur/neovim-ayu", lazy = false, priority = 1000 },
  -- theme switcher
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
        vim.cmd("colorscheme ayu-mirage")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
        vim.cmd("colorscheme ayu-light")
      end,
    },
  },
  -- formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        json = { { "prettierd", "prettier" } },
        javascript = { { "eslint_d", "eslint" }, { "prettierd", "prettier" } },
        typescript = { { "eslint_d", "eslint" }, { "prettierd", "prettier" } },
        typescriptreact = { { "eslint_d", "eslint" }, { "prettierd", "prettier" } },
        javascriptreact = { { "eslint_d", "eslint" }, { "prettierd", "prettier" } },
      },
    },
  },
  -- starter
  {
    "echasnovski/mini.starter",
    opts = {
      header = table.concat({

        " ██████╗██╗  ██╗██████╗ ██╗███████╗██╗   ██╗██╗███╗   ███╗",
        "██╔════╝██║  ██║██╔══██╗██║██╔════╝██║   ██║██║████╗ ████║",
        "██║     ███████║██████╔╝██║███████╗██║   ██║██║██╔████╔██║",
        "██║     ██╔══██║██╔══██╗██║╚════██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "╚██████╗██║  ██║██║  ██║██║███████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
        " ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
      }, "\n"),
    },
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
      },
    },
  },
  -- barbecue
  {
    "utilyre/barbecue.nvim",
    event = "BufRead",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  -- better looking folds
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
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
  },
  -- zoxide in telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "jvgrootveld/telescope-zoxide",
    },
    config = function()
      require("telescope").load_extension("zoxide")
    end,
    keys = {
      { "<leader>sn", "<cmd>Telescope notify<CR>", desc = "Notifications" },
      { "<leader>fw", "<cmd>Telescope zoxide list<CR>", desc = "Workspace" },
      { "<leader>fb", false },
      {
        "<leader>ff",
        function()
          vim.fn.system("git rev-parse --is-inside-work-tree")
          if vim.v.shell_error == 0 then
            require("telescope.builtin").git_files({ show_untracked = true })
          else
            require("telescope.builtin").find_files({})
          end
        end,
        desc = "Find Files",
      },
      { "<leader><space>", "<leader>ff", remap = true, desc = "Find files" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      filesystem = {
        hijack_netrw_behavior = "open_current",
      },
    },
  },
}
