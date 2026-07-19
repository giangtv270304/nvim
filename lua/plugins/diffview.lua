return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview: xem thay đổi" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: lịch sử file" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: lịch sử repo" },
    { "<leader>gc", "<cmd>DiffviewClose<CR>", desc = "Diffview: đóng" },
  },
}
