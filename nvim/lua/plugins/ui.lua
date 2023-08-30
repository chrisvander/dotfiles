return {
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
  -- barbecue
  {
    "utilyre/barbecue.nvim",
    event = "BufRead",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = { attach_navic = false },
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
    opts = {
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
 indent = { enable = true },
    },
    config = function(opts) require("nvim-treesitter.configs").setup(opts) end,
  },
}
