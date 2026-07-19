return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  vscode = true, -- keep working in VSCode Neovim (the vscode extra only enables mini.surround by default)
  opts = {},
  -- Usage: ysiw" (wrap word in "), cs"' (change " to '), ds( (remove surrounding brackets)
}
