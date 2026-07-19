return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {},
  keys = {
    { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Markdown: toggle render" },
  },
}
