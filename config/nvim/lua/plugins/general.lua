local Util = require("lazyvim.util")
local icons = require("lazyvim.config").icons

return {
  {
    "LazyVim/LazyVim",
    dependencies = { "neovim-ayu" },
    opts = {
      colorscheme = "ayu-mirage",
    },
  },
  { "echasnovski/mini.pairs", enabled = false },
  -- theme
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      require("ayu").setup({
        overrides = {
          Normal = { bg = "None" },
          ColorColumn = { bg = "None" },
          SignColumn = { bg = "None" },
          Folded = { bg = "None" },
          FoldColumn = { bg = "None" },
          CursorLine = { bg = "None" },
          CursorColumn = { bg = "None" },
          WhichKeyFloat = { bg = "None" },
          VertSplit = { bg = "None" },
          DashboardHeader = { fg = "#FFAD66" },
          DashboardCenter = { fg = "#F28779" },
          DashboardFooter = { fg = "#73D0FF" },
        },
      })
    end,
  },
  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     update_interval = 1000,
  --     set_dark_mode = function()
  --       vim.api.nvim_set_option("background", "dark")
  --       vim.cmd("colorscheme ayu-mirage")
  --     end,
  --     set_light_mode = function()
  --       vim.api.nvim_set_option("background", "light")
  --       vim.cmd("colorscheme ayu-light")
  --     end,
  --   },
  -- },
  -- formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        sql_formatter = {
          command = "sql-formatter",
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        sql = { "sql_formatter" },
        python = { "isort", "black" },
        json = { "biome" },
        terraform = { "terraform_fmt" },
        javascript = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        javascriptreact = { "biome" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ["*"] = { "biomejs" },
        markdown = { "markdownlint" },
        json = { "biomejs" },
        javascript = { "biomejs" },
        typescript = { "biomejs" },
        typescriptreact = { "biomejs" },
        javascriptreact = { "biomejs" },
      },
    },
  },
  -- starter
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
 ██████╗██╗  ██╗██████╗ ██╗███████╗██╗   ██╗██╗███╗   ███╗
██╔════╝██║  ██║██╔══██╗██║██╔════╝██║   ██║██║████╗ ████║
██║     ███████║██████╔╝██║███████╗██║   ██║██║██╔████╔██║
██║     ██╔══██║██╔══██╗██║╚════██║╚██╗ ██╔╝██║██║╚██╔╝██║
╚██████╗██║  ██║██║  ██║██║███████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
        },
      },
    },
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "tzachar/cmp-ai",
  --     "nvim-lua/plenary.nvim",
  --     {
  --       "tzachar/cmp-ai",
  --       opts = {
  --         max_lines = 1000,
  --         provider = "Ollama",
  --         provider_options = {
  --           model = "codellama",
  --           -- stream = true,
  --         },
  --         -- notify = true,
  --         -- notify_callback = function(msg)
  --         --   vim.notify(msg)
  --         -- end,
  --         run_on_every_keystroke = true,
  --         ignored_file_types = {
  --           -- default is not to ignore
  --           -- uncomment to ignore in lua:
  --           -- lua = true
  --         },
  --       },
  --       config = function(_, opts)
  --         require("cmp_ai.config"):setup(opts)
  --       end,
  --     },
  --   },
  --   opts = function(_, opts)
  --     table.insert(opts.sources, {
  --       name = "cmp_ai",
  --       -- group_index = 1,
  --       -- priority = 100,
  --     })
  --   end,
  -- },
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
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
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
      { "<leader><space>", false },
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
      {
        "<leader>C",
        function()
          Util.pick.config_files()
        end,
        desc = "Find Config File",
      },
      {
        "<leader>f",
        function()
          Util.pick.open("files")
        end,
        desc = "Find Files (root dir)",
      },
      {
        "<leader>F",
        function()
          Util.pick.open("files", { cwd = vim.uv.cwd() })
        end,
        desc = "Find Files (cwd)",
      },
      { "<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      {
        "<leader>R",
        function()
          Util.pick.open("oldfiles", { cwd = vim.uv.cwd() })
        end,
        desc = "Recent (cwd)",
      },
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
    "https://github.com/apple/pkl-neovim",
    lazy = true,
    event = "BufReadPre *.pkl",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      vim.cmd("TSInstall! pkl")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.theme = "ayu"
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
  -- disable animations
  { "rcarriga/nvim-notify", opts = { render = "compact", stages = "static" } },
}
