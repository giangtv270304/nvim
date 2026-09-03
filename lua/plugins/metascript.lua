return {
  "metascriptlang/metascript.nvim",
  ft = { "metascript" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    -- Optional:
    -- "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    server_path = "msc",
    lsp = {
      cmd = { vim.fn.expand("$HOME/.metascript/bin/msc"), "lsp" },
    },
    treesitter = true,
  },
}
