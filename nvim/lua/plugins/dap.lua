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
        automatic_setup = true
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
