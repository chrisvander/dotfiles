require('neotest').setup({
  adapters = {
    require('neotest-python'),
    require('neotest-vitest'),
    require('neotest-jest'),
    require('neotest-go'),
    require('neotest-rust')
  },
  consumers = {
    overseer = require("neotest.consumers.overseer"),
  },
})
