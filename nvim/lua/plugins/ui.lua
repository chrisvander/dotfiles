return {
  -- theme
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },
  -- scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = true,
    opts = {
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
      },
    },
  },
  -- git status
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = true,
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 1000,
      },
    },
    keys = {
      { "<leader>D", "<cmd>Gitsigns diffthis<CR>" },
    },
  },
  "nvim-tree/nvim-web-devicons",
  -- tree
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   dependencies = {
  --     "nvim-web-devicons"
  --   },
  --   config = true,
  --   opts = {
  --     filters = {
  --       custom = { ".git", "node_modules", ".cache", "*.lock" },
  --     },
  --     git = {
  --       ignore = false,
  --     },
  --   },
  --   keys = {
  --     { "<leader>e", "<cmd>NvimTreeToggle<CR>" },
  --   },
  -- },
  -- barbecue
  {
    "utilyre/barbecue.nvim",
    event = "BufRead",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-web-devicons",
    },
    opts = { attach_navic = false },
  },
  -- sidebar
  {
    'sidebar-nvim/sidebar.nvim',
    config = true,
    lazy = false,
    keys = {
      { "<leader>e", "<cmd>SidebarNvimToggle<CR>" },
    },
  },
  -- IN-EDITOR --
  -- folding
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
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
      },
    },
  },
  -- indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = true,
  },
  -- colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
  },
  -- highlighter
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
}
