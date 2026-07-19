-- LazyVim loads this file AFTER its own default keymaps (on the VeryLazy
-- event), so any mapping below that reuses the same key wins over the
-- LazyVim default.
--
-- IMPORTANT: this file also loads after lua/plugins/vscode.lua (the
-- LazyVimKeymapsDefaults autocmd runs before config.keymaps is required).
-- So any map here that shares a key with vscode.lua wins over the VSCode
-- command call — but runs as plain Vim commands against nvim's hidden
-- window/buffer/tab, which in VSCode means the key "does something" with
-- no visible effect (desynced from the real UI). That's why the
-- window/buffer/split/tab/terminal/diagnostic blocks below are wrapped in
-- `if not vim.g.vscode` to leave them to vscode.lua instead.
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- vscode-neovim intercepts :w/:q itself to call the real VSCode commands
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

if not vim.g.vscode then
  -- Move between windows with Ctrl + hjkl
  map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
  map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
  map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
  map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

  -- Resize windows
  map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase height" })
  map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

  -- Switch buffers
  map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
  map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
  map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
end

-- Move selected lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep the selection after indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Keep the cursor centered while scrolling / searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

if not vim.g.vscode then
  -- ===== Splits =====
  map("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
  map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
  map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
  map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
  map("n", "<leader>so", "<C-w>o", { desc = "Close all other splits" })

  -- ===== Tabs =====
  map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
  map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
  map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })
  map("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
  map("n", "<leader>tf", "<C-w>T", { desc = "Move current file to a new tab" })

  -- ===== Terminal =====
  map("n", "<leader>th", "<cmd>split | terminal<CR>", { desc = "Terminal (horizontal)" })
  map("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Terminal (vertical)" })
  -- Esc Esc to leave terminal insert mode (use <C-\> for toggleterm)
  map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal: back to normal mode" })

  -- Basic diagnostics (full list lives in trouble.nvim under <leader>x)
  -- Note: <leader>e is owned by neo-tree (toggle file tree)
  map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
  map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
  map("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Line diagnostics" })
end
