-- =============================================================================
--  "Pro LazyVim" keymap set for VSCode Neovim (asvetliakov.vscode-neovim)
-- =============================================================================
--  * This file ONLY runs when Neovim is embedded in VSCode (vim.g.vscode = true).
--    In a real terminal it returns {} and has no effect.
--  * Every command is called through the extension's `vscode` module:
--      - vscode.action(name)  -> run a VSCode command (async, fire-and-forget)
--      - vscode.call(name)    -> run synchronously, wait for it to finish
--        (use when ordering matters)
--  * Keymaps are registered on the LazyVimKeymapsDefaults event so they layer
--    in after LazyVim's own default keymaps (same approach as the vscode extra).
--  * See README.md in this repo for the full VSCode Neovim setup.
-- =============================================================================

if not vim.g.vscode then
  return {}
end

local vscode = require("vscode")

-- helper: build a callback that runs one VSCode command
local function action(name)
  return function()
    vscode.action(name)
  end
end

-- helper: run synchronously (for actions that must finish before continuing)
local function call(name)
  return function()
    vscode.call(name)
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymapsDefaults",
  callback = function()
    local map = vim.keymap.set

    -- ----------------------------------------------------------------------
    --  LSP / Code navigation
    -- ----------------------------------------------------------------------
    map("n", "gd", action("editor.action.revealDefinition"), { desc = "Goto Definition" })
    map("n", "gD", action("editor.action.revealDeclaration"), { desc = "Goto Declaration" })
    map("n", "gr", action("editor.action.goToReferences"), { desc = "References" })
    map("n", "gI", action("editor.action.goToImplementation"), { desc = "Goto Implementation" })
    map("n", "gy", action("editor.action.goToTypeDefinition"), { desc = "Goto Type Definition" })
    map("n", "gp", action("editor.action.peekDefinition"), { desc = "Peek Definition" })
    map("n", "K", action("editor.action.showHover"), { desc = "Hover" })

    -- ----------------------------------------------------------------------
    --  Code actions (<leader>c)
    -- ----------------------------------------------------------------------
    map("n", "<leader>ca", action("editor.action.quickFix"), { desc = "Code Action" })
    map("n", "<leader>cr", action("editor.action.rename"), { desc = "Rename Symbol" })
    map("n", "<leader>cd", action("editor.action.showHover"), { desc = "Line Diagnostics" })
    map("n", "<leader>co", action("editor.action.organizeImports"), { desc = "Organize Imports" })
    map("n", "<leader>cf", action("editor.action.formatDocument"), { desc = "Format Document" })
    map("x", "<leader>cf", call("editor.action.formatSelection"), { desc = "Format Selection" })
    map("n", "<leader>cs", action("workbench.action.gotoSymbol"), { desc = "Symbols (file)" })
    map("n", "<leader>cS", action("workbench.action.showAllSymbols"), { desc = "Symbols (workspace)" })

    -- ----------------------------------------------------------------------
    --  Diagnostics & git hunk navigation
    -- ----------------------------------------------------------------------
    map("n", "]d", action("editor.action.marker.nextInFiles"), { desc = "Next Diagnostic" })
    map("n", "[d", action("editor.action.marker.prevInFiles"), { desc = "Prev Diagnostic" })
    map("n", "]h", action("workbench.action.editor.nextChange"), { desc = "Next Git Change" })
    map("n", "[h", action("workbench.action.editor.previousChange"), { desc = "Prev Git Change" })

    -- ----------------------------------------------------------------------
    --  Find / Files (<leader>f) + Explorer
    -- ----------------------------------------------------------------------
    map("n", "<leader>ff", action("workbench.action.quickOpen"), { desc = "Find Files" })
    map("n", "<leader>fr", action("workbench.action.openRecent"), { desc = "Recent Files" })
    map("n", "<leader>fg", action("workbench.action.findInFiles"), { desc = "Grep (find in files)" })
    map("n", "<leader>fb", action("workbench.action.showAllEditors"), { desc = "Open Buffers" })
    map("n", "<leader>fn", action("workbench.action.files.newUntitledFile"), { desc = "New File" })
    map("n", "<leader>fs", action("workbench.action.files.save"), { desc = "Save File" })
    -- <leader>e / <leader>E are overridden in the snacks.nvim spec at the
    -- bottom of this file (the default keymaps are attached to snacks via
    -- `keys=`, so they must be overridden at that same spot)

    -- ----------------------------------------------------------------------
    --  Search (<leader>s)
    -- ----------------------------------------------------------------------
    map("n", "<leader>sg", action("workbench.action.findInFiles"), { desc = "Grep" })
    map("n", "<leader>sr", action("workbench.action.replaceInFiles"), { desc = "Search & Replace" })
    map("n", "<leader>sd", action("workbench.actions.view.problems"), { desc = "Diagnostics" })
    map("n", "<leader>sc", action("workbench.action.showCommands"), { desc = "Command Palette" })
    map("n", "<leader>sk", action("workbench.action.openGlobalKeybindings"), { desc = "Keymaps" })
    map("n", "<leader>sS", action("workbench.action.showAllSymbols"), { desc = "Workspace Symbols" })
    map("n", "<leader>sw", function()
      vscode.action("workbench.action.findInFiles", { args = { query = vim.fn.expand("<cword>") } })
    end, { desc = "Search word under cursor" })

    -- ----------------------------------------------------------------------
    --  Buffers (<leader>b) + tab navigation
    -- ----------------------------------------------------------------------
    map("n", "<leader>bd", action("workbench.action.closeActiveEditor"), { desc = "Close Buffer" })
    map("n", "<leader>bo", action("workbench.action.closeOtherEditors"), { desc = "Close Others" })
    map("n", "<leader>bp", action("workbench.action.pinEditor"), { desc = "Pin Buffer" })
    map("n", "<S-h>", call("workbench.action.previousEditor"), { desc = "Prev Buffer" })
    map("n", "<S-l>", call("workbench.action.nextEditor"), { desc = "Next Buffer" })

    -- ----------------------------------------------------------------------
    --  Windows / Editor groups (<leader>w + <C-hjkl>)
    -- ----------------------------------------------------------------------
    map("n", "<leader>wv", action("workbench.action.splitEditor"), { desc = "Split Right" })
    map("n", "<leader>ws", action("workbench.action.splitEditorDown"), { desc = "Split Down" })
    map("n", "<leader>wd", action("workbench.action.closeEditorsInGroup"), { desc = "Close Group" })
    map("n", "<leader>ww", action("workbench.action.focusNextGroup"), { desc = "Other Group" })
    map("n", "<leader>wm", action("workbench.action.toggleMaximizeEditorGroup"), { desc = "Maximize Group" })
    map("n", "<leader>wh", action("workbench.action.focusLeftGroup"), { desc = "Focus Left" })
    map("n", "<leader>wj", action("workbench.action.focusBelowGroup"), { desc = "Focus Below" })
    map("n", "<leader>wk", action("workbench.action.focusAboveGroup"), { desc = "Focus Above" })
    map("n", "<leader>wl", action("workbench.action.focusRightGroup"), { desc = "Focus Right" })
    -- Ctrl-hjkl group navigation is deliberately NOT mapped here. VSCode's
    -- keybindings.json handles these 4 keys directly (workbench.action.focusXGroup,
    -- when neovim.mode=='normal'), and "vscode-neovim.ctrlKeysForNormalMode" in
    -- settings.json excludes h/j/k/l from the set the extension forwards into
    -- nvim — so a map here would never fire (avoids a duplicate/dead keybinding).

    -- ----------------------------------------------------------------------
    --  Git (<leader>g)
    -- ----------------------------------------------------------------------
    map("n", "<leader>gg", action("workbench.view.scm"), { desc = "Source Control" })
    map("n", "<leader>gb", action("gitlens.toggleFileBlame"), { desc = "Toggle Blame (GitLens)" })
    map("n", "<leader>gd", action("git.openChange"), { desc = "Open Diff" })
    map("n", "<leader>gh", action("git.viewFileHistory"), { desc = "File History" })

    -- ----------------------------------------------------------------------
    --  Diagnostics list / Trouble (<leader>x)
    -- ----------------------------------------------------------------------
    map("n", "<leader>xx", action("workbench.actions.view.problems"), { desc = "Problems" })
    map("n", "<leader>xl", action("workbench.actions.view.problems"), { desc = "Problems" })

    -- ----------------------------------------------------------------------
    --  UI toggles (<leader>u)
    -- ----------------------------------------------------------------------
    map("n", "<leader>uw", action("editor.action.toggleWordWrap"), { desc = "Toggle Word Wrap" })
    map("n", "<leader>uz", action("workbench.action.toggleZenMode"), { desc = "Zen Mode" })
    map("n", "<leader>uc", action("workbench.action.selectTheme"), { desc = "Colorscheme" })
    map("n", "<leader>um", action("editor.action.toggleMinimap"), { desc = "Toggle Minimap" })

    -- ----------------------------------------------------------------------
    --  Debug (<leader>d) — uses VSCode's debugger
    -- ----------------------------------------------------------------------
    map("n", "<leader>db", action("editor.debug.action.toggleBreakpoint"), { desc = "Toggle Breakpoint" })
    map("n", "<leader>dc", action("workbench.action.debug.continue"), { desc = "Continue" })
    map("n", "<leader>dC", action("workbench.action.debug.run"), { desc = "Run / Start" })
    map("n", "<leader>di", action("workbench.action.debug.stepInto"), { desc = "Step Into" })
    map("n", "<leader>do", action("workbench.action.debug.stepOver"), { desc = "Step Over" })
    map("n", "<leader>dO", action("workbench.action.debug.stepOut"), { desc = "Step Out" })
    map("n", "<leader>dt", action("workbench.action.debug.stop"), { desc = "Stop" })

    -- ----------------------------------------------------------------------
    --  Test (<leader>t) — uses VSCode's Test Explorer
    -- ----------------------------------------------------------------------
    map("n", "<leader>tt", action("testing.runAtCursor"), { desc = "Run Nearest Test" })
    map("n", "<leader>tT", action("testing.runAll"), { desc = "Run All Tests" })
    map("n", "<leader>td", action("testing.debugAtCursor"), { desc = "Debug Nearest Test" })

    -- ----------------------------------------------------------------------
    --  Quit / misc (<leader>q)
    -- ----------------------------------------------------------------------
    map("n", "<leader>qq", action("workbench.action.closeWindow"), { desc = "Quit Window" })
    -- Esc also clears search highlight (keeps LazyVim's behavior)
    map("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear search highlight" })
  end,
})

return {
  -- ------------------------------------------------------------------------
  --  Override the default keymaps attached to snacks.nvim via `keys=`.
  --  Snacks' explorer/picker open floating Neovim windows that VSCode CANNOT
  --  render -> clicking into them just looks broken. This user spec loads
  --  AFTER LazyVim, so a matching `keys` lhs here wins and calls the
  --  equivalent VSCode command instead.
  -- ------------------------------------------------------------------------
  {
    "snacks.nvim",
    keys = {
      { "<leader>e", function() vscode.action("workbench.files.action.focusFilesExplorer") end, desc = "Focus Explorer" },
      { "<leader>E", function() vscode.action("workbench.action.toggleSidebarVisibility") end, desc = "Toggle Sidebar" },
      { "<leader>ff", function() vscode.action("workbench.action.quickOpen") end, desc = "Find Files" },
      { "<leader>fg", function() vscode.action("workbench.action.findInFiles") end, desc = "Grep" },
      { "<leader>fr", function() vscode.action("workbench.action.openRecent") end, desc = "Recent Files" },
      { "<leader>fb", function() vscode.action("workbench.action.showAllEditors") end, desc = "Buffers" },
      { "<leader>sg", function() vscode.action("workbench.action.findInFiles") end, desc = "Grep" },
      { "<leader>gg", function() vscode.action("workbench.view.scm") end, desc = "Source Control" },
    },
  },
}
