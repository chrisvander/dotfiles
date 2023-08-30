return {
  { "williamboman/mason.nvim", lazy = true, config = true, build = ":MasonUpdate" },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>" },
      { "<leader>dc", "<cmd>lua require('dap').continue()<CR>" },
      { "<leader>di", "<cmd>lua require('dap').step_into()<CR>" },
      { "<leader>do", "<cmd>lua require('dap').step_over()<CR>" },
      { "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>" },
      { "<leader>ds", "<cmd>lua require('dap').continue()<CR>" },
      { "<leader>dt", "<cmd>lua require('dap').step_out()<CR>" },
      { "<leader>du", "<cmd>lua require('dap').up()<CR>" },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "nvim-dap",
      "mason.nvim",
    },
    config = function()
      require("mason-nvim-dap").setup({
        automatic_setup = true,
        handlers = {
          function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality
            require('mason-nvim-dap').default_setup(config)
          end,
          rust = function(config)
            config.adapter = {
              type = 'server',
              port = "${port}",
              executable = {
                command = '/usr/bin/codelldb',
                args = { "--port", "${port}" },
              }
            }

            require('mason-nvim-dap').default_setup(config) -- don't forget this!
          end,
        },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "nvim-dap",
    config = true,
    keys = { {
      "<leader>dd",
      function()
        require("dapui").toggle()
      end,
      { silent = true },
    } },
  }
}
