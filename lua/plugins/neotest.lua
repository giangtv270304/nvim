return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "fredrikaverpil/neotest-golang", -- adapter Go (bản được duy trì)
    "nvim-neotest/neotest-jest",     -- adapter JS/TS
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-golang"),
        require("neotest-jest"),
      },
    })
  end,
  -- Dùng <leader>T (chữ HOA) để không đè <leader>t (tab/terminal)
  keys = {
    { "<leader>Tr", function() require("neotest").run.run() end, desc = "Test: chạy test gần nhất" },
    { "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: chạy cả file" },
    { "<leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: debug (cần DAP)" },
    { "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "Test: bảng tổng kết" },
    { "<leader>To", function() require("neotest").output.open({ enter = true }) end, desc = "Test: xem output" },
    { "<leader>TS", function() require("neotest").run.stop() end, desc = "Test: dừng" },
  },
}
