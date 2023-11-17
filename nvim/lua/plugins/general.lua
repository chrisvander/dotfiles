local Util = require("lazyvim.util")
local icons = require("lazyvim.config").icons

return {
  { dir = "chrisvander/ollama.nvim", dev = true, lazy = false, opts = {} },
  -- theme
  { "Shatur/neovim-ayu", lazy = false, priority = 1000 },
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
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
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
  },
  -- zoxide in telescope
  --
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "jvgrootveld/telescope-zoxide",
    },
    config = function()
      require("telescope").load_extension("zoxide")
    end,
    keys = {
      { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fw", false },
      { "<leader>fb", false },
      { "<leader>fc", false },
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fr", false },
      { "<leader>fR", false },
      { "<leader>w", "<cmd>Telescope zoxide list<CR>", desc = "Workspace" },
      { "<leader>b", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>C", Util.telescope.config_files(), desc = "Find Config File" },
      { "<leader>f", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>F", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>R", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
      -- search
      { "<leader>sn", "<cmd>Telescope notify<CR>", desc = "Notifications" },
    },
  },
  -- hijack netrw
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
  -- disable textDocument/hover from noice so we can override filters in options
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = { enabled = false },
        override = {
          ["textDocument/hover"] = false,
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections.lualine_c = {
        Util.lualine.root_dir(),
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { Util.lualine.pretty_path() },
      }
    end,
  },
  -- remap mini files
  {
    "echasnovski/mini.files",
    keys = {
      { "<leader>fm", false },
      { "<leader>fM", false },
      {
        "<leader>m",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (directory of current file)",
      },
      {
        "<leader>M",
        function()
          require("mini.files").open(vim.loop.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
  },
  -- disable animations
  { "rcarriga/nvim-notify", opts = { render = "compact", stages = "static" } },
}
