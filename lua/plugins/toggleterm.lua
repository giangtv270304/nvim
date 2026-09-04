-- Floating terminal can't render in VSCode; vscode.lua's <leader>gg opens Source Control instead.
if vim.g.vscode then
  return {}
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { [[<C-\>]], desc = "Toggle terminal" },
    { "<leader>gg", desc = "Lazygit" },
  },
  opts = {
    open_mapping = [[<c-\>]], -- Ctrl-\ toggles the floating terminal
    direction = "float",
    float_opts = { border = "curved" },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Dedicated terminal running lazygit (requires: brew install lazygit)
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
    vim.keymap.set("n", "<leader>gg", function()
      lazygit:toggle()
    end, { desc = "Lazygit" })
  end,
}
