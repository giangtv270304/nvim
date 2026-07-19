return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    user_default_options = {
      names = false, -- don't highlight color names like "red", only actual color codes
      css = true,
      tailwind = true,
    },
  },
}
