return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      diagnostics = "nvim_lsp", -- hiện lỗi LSP ngay trên tab file
      show_buffer_close_icons = true,
      show_close_icon = false,
      separator_style = "thin", -- gạch dọc mảnh, gọn gàng (slant to bị xấu trên nhiều font)
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          separator = true,
          text_align = "left",
        },
      },
    },
  },
  keys = {
    -- <S-h> / <S-l> đã chuyển buffer (di chuyển giữa các tab này)
    { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Ghim buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Đóng các buffer khác" },
    { "<leader>b1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Buffer 1" },
    { "<leader>b2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Buffer 2" },
    { "<leader>b3", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Buffer 3" },
  },
}
