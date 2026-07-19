return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "fredrikaverpil/neotest-golang", -- Go adapter (actively maintained)
    "nvim-neotest/neotest-jest",     -- JS/TS adapter
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-golang"),
        require("neotest-jest"),
      },
    })
  end,
  -- Uses <leader>T (capital T) so it doesn't collide with <leader>t (tab/terminal)
  keys = {
    { "<leader>Tr", function() require("neotest").run.run() end, desc = "Test: run nearest" },
    { "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: run file" },
    { "<leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: debug (requires DAP)" },
    { "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "Test: summary" },
    { "<leader>To", function() require("neotest").output.open({ enter = true }) end, desc = "Test: view output" },
    { "<leader>TS", function() require("neotest").run.stop() end, desc = "Test: stop" },
  },
}
