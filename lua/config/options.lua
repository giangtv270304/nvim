-- [[ Tùy chọn chung ]]

-- Ép LazyVim dùng đúng nhánh mình đang cấu hình thủ công, không tự chọn
-- default mới (blink.cmp / snacks explorer / snacks picker). File này nạp
-- SAU lazyvim.config.options (default của LazyVim) nên mới ghi đè được.
vim.g.lazyvim_cmp = "nvim-cmp"
vim.g.lazyvim_explorer = "neo-tree"
vim.g.lazyvim_picker = "telescope"

local opt = vim.opt

-- Số dòng
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- Thụt lề: 2 space là chuẩn cho yaml / terraform / js / ts / ansible
-- (Go dùng tab thật — được xử lý riêng trong autocmds.lua)
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.autoindent = true

-- Tìm kiếm
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Giao diện
opt.list = false -- tắt hiện ký tự ẩn (LazyVim bật mặc định -> tab thật hiện icon ">")
opt.termguicolors = true
opt.signcolumn = "yes"   -- luôn chừa cột dấu (git/diagnostic không nhảy layout)
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.pumheight = 10       -- chiều cao tối đa của menu completion

-- Chia cửa sổ
opt.splitright = true
opt.splitbelow = true

-- File / undo
opt.swapfile = false
opt.backup = false
opt.undofile = true      -- giữ undo qua các lần mở lại file
opt.undolevels = 10000

-- Hành vi
opt.mouse = "a"
opt.clipboard = "unnamedplus"                 -- dùng clipboard hệ thống
opt.updatetime = 250                          -- phản hồi nhanh hơn (hover, gitsigns)
opt.timeoutlen = 400                          -- chờ phím tiếp theo cho leader/which-key
opt.ttimeoutlen = 10                          -- KHÔNG để kế thừa timeoutlen (mặc định -1):
                                               -- nếu không set riêng, mỗi lần bấm Esc để
                                               -- thoát insert mode sẽ bị "khựng" tới 400ms
                                               -- vì Nvim chờ xem có phải mã phím Alt/F-key
                                               -- gửi qua terminal hay không. Tách riêng ra
                                               -- để Esc phản hồi gần như ngay lập tức.
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true                            -- hỏi lưu thay vì báo lỗi khi thoát

-- Cuộn / rê chuột mượt hơn
opt.mousescroll = "ver:1,hor:0"                -- mỗi nấc lăn chuột = 1 dòng (mượt hơn 3 dòng/nấc mặc định),
                                                -- ăn khớp với animation cuộn mượt của snacks.nvim (đã bật sẵn
                                                -- qua LazyVim - xem lazyvim/plugins/ui.lua, scroll.enabled=true)
vim.g.loaded_matchparen = 1                    -- tắt highlight ngoặc khớp: bớt tính toán lại mỗi lần
                                                -- di chuyển con trỏ qua dấu ngoặc, gõ/di chuyển mượt hơn

-- Giao diện diagnostics (báo lỗi)
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})
