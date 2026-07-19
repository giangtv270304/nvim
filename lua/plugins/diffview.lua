return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview: view changes" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: file history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: repo history" },
    { "<leader>gc", "<cmd>DiffviewClose<CR>", desc = "Diffview: close" },
  },
}
