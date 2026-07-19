return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      diagnostics = "nvim_lsp", -- show LSP errors right on the file tab
      show_buffer_close_icons = true,
      show_close_icon = false,
      separator_style = "thin", -- thin, clean divider (slant looks broken on many fonts)
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
    -- <S-h> / <S-l> already switch buffers (moves between these tabs)
    { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Pin buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
    { "<leader>b1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Buffer 1" },
    { "<leader>b2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Buffer 2" },
    { "<leader>b3", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Buffer 3" },
  },
}
