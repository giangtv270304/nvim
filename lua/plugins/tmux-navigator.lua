-- =============================================================================
--  Seamless pane navigation between Neovim splits and tmux panes (Ctrl-hjkl)
-- =============================================================================
--  * Only useful in a real terminal + tmux. Disabled when embedded in VSCode
--    (vscode.lua already owns Ctrl-hjkl for VSCode group focus there).
--  * Needs matching tmux.conf bindings, see README.md in this repo.
-- =============================================================================

if vim.g.vscode then
  return {}
end

return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  -- Plugin auto-maps <C-h/j/k/l/\> by default; <C-\> collides with
  -- toggleterm's open_mapping. We define our own keys below instead.
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to left pane/split" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to below pane/split" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to above pane/split" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right pane/split" },
  },
}
