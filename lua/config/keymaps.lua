-- File này được LazyVim tự nạp SAU keymaps mặc định của nó (qua sự kiện VeryLazy),
-- nên các map trùng phím bên dưới sẽ ghi đè lên default của LazyVim.
--
-- QUAN TRỌNG: file này cũng nạp SAU lua/plugins/vscode.lua (autocmd
-- LazyVimKeymapsDefaults chạy trước _load("config.keymaps")). Vì vậy MỌI map
-- ở đây trùng phím với vscode.lua sẽ THẮNG và ghi đè bản gọi lệnh VSCode —
-- nhưng lại chạy bằng lệnh Vim thuần trên window/buffer/tab ẩn của nvim, nên
-- trong VSCode phím bấm "chạy" mà không thấy hiệu ứng gì (desync với UI thật).
-- Những khối liên quan window/buffer/split/tab/terminal/diagnostic bên dưới
-- vì vậy được bọc trong `if not vim.g.vscode` để nhường lại cho vscode.lua.
local map = vim.keymap.set

-- Xoá highlight sau khi tìm kiếm
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Lưu / thoát nhanh (vscode-neovim tự chặn :w/:q để gọi lệnh VSCode thật)
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

if not vim.g.vscode then
  -- Di chuyển giữa các cửa sổ bằng Ctrl + hjkl
  map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
  map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
  map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
  map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

  -- Đổi kích thước cửa sổ
  map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase height" })
  map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

  -- Chuyển buffer
  map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
  map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
  map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
end

-- Di chuyển dòng trong visual mode (Alt/Shift J-K)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Giữ vùng chọn sau khi thụt lề
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Giữ con trỏ giữa màn hình khi cuộn / tìm
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

if not vim.g.vscode then
  -- ===== Split (chia cửa sổ) =====
  map("n", "<leader>sv", "<C-w>v", { desc = "Split dọc" })
  map("n", "<leader>sh", "<C-w>s", { desc = "Split ngang" })
  map("n", "<leader>se", "<C-w>=", { desc = "Cân bằng split" })
  map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Đóng split" })
  map("n", "<leader>so", "<C-w>o", { desc = "Chỉ giữ split này" })

  -- ===== Tab =====
  map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Tab mới" })
  map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Đóng tab" })
  map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Tab sau" })
  map("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Tab trước" })
  map("n", "<leader>tf", "<C-w>T", { desc = "Đưa file hiện tại sang tab mới" })

  -- ===== Terminal =====
  map("n", "<leader>th", "<cmd>split | terminal<CR>", { desc = "Terminal (ngang)" })
  map("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Terminal (dọc)" })
  -- Esc Esc để ra normal mode trong terminal (dùng <C-\> cho toggleterm)
  map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal: về normal mode" })

  -- Diagnostics cơ bản (danh sách đầy đủ ở trouble.nvim với <leader>x)
  -- Lưu ý: <leader>e do neo-tree đảm nhận (toggle cây thư mục)
  map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
  map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
  map("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Line diagnostics" })
end
