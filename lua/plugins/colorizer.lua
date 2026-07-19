return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    user_default_options = {
      names = false, -- không tô các chữ như "red", chỉ tô mã màu
      css = true,
      tailwind = true,
    },
  },
}
