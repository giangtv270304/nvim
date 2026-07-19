# ⌨️ Neovim Keymaps Cheat-Sheet

> `<leader>` = **Space**. Quy ước: `<C-x>` = Ctrl+x, `<S-x>` = Shift+x, `<A-x>` = Alt+x.
> Cột **Mode**: `n` normal · `i` insert · `v` visual · `t` terminal · `o` operator-pending.

## 📑 Mục lục

1. [Cơ bản (lưu / thoát / tìm)](#1-cơ-bản)
2. [Di chuyển nhanh](#2-di-chuyển-nhanh)
3. [Cửa sổ & Split](#3-cửa-sổ--split)
4. [Tab](#4-tab)
5. [Buffer & Bufferline](#5-buffer--bufferline)
6. [File Explorer (neo-tree)](#6-file-explorer-neo-tree)
7. [Tìm kiếm (Telescope)](#7-tìm-kiếm-telescope)
8. [Harpoon (ghim file)](#8-harpoon-ghim-file)
9. [LSP (code intelligence)](#9-lsp-code-intelligence)
10. [Completion (khi gõ code)](#10-completion-khi-gõ-code)
11. [Chỉnh sửa nâng cao (text object, surround)](#11-chỉnh-sửa-nâng-cao)
12. [Format & Lint](#12-format--lint)
13. [Diagnostics & Trouble](#13-diagnostics--trouble)
14. [Git](#14-git)
15. [Test (neotest)](#15-test-neotest)
16. [Terminal](#16-terminal)
17. [Vim thuần — nền tảng phải nhớ](#17-vim-thuần--nền-tảng-phải-nhớ)

---

## 1. Cơ bản

| Phím | Mode | Việc |
|------|------|------|
| `<leader>w` | n | Lưu file |
| `<leader>q` | n | Thoát cửa sổ |
| `<Esc>` | n | Xoá highlight sau khi tìm |
| `/` … `n` `N` | n | Tìm trong file · kết quả sau/trước |
| `<C-d>` `<C-u>` | n | Cuộn nửa trang (con trỏ giữ giữa) |

---

## 2. Di chuyển nhanh

| Phím | Mode | Việc |
|------|------|------|
| `s` + 2 ký tự | n/v/o | **Flash**: nhảy tới bất kỳ đâu trên màn hình |
| `S` | n/v/o | **Flash**: nhảy theo khối treesitter |
| `f<c>` `t<c>` | n | Nhảy tới / trước ký tự `c` trên dòng (`;` `,` lặp) |
| `%` | n | Nhảy tới ngoặc tương ứng |
| `*` `#` | n | Nhảy tới từ dưới con trỏ (tiếp / trước) |
| `{` `}` | n | Nhảy theo đoạn |
| `<C-o>` `<C-i>` | n | Quay lại / tiến vị trí nhảy (jumplist) |
| `]f` `[f` | n | Hàm tiếp / trước |
| `]C` `[C` | n | Class/struct tiếp / trước |

---

## 3. Cửa sổ & Split

| Phím | Mode | Việc |
|------|------|------|
| `<leader>sv` | n | Chia dọc |
| `<leader>sh` | n | Chia ngang |
| `<leader>se` | n | Cân bằng kích thước |
| `<leader>sx` | n | Đóng ô hiện tại |
| `<leader>so` | n | Chỉ giữ ô này |
| `<C-h/j/k/l>` | n | Di chuyển giữa các ô |
| `<C-↑/↓/←/→>` | n | Đổi kích thước ô |

---

## 4. Tab

| Phím | Mode | Việc |
|------|------|------|
| `<leader>to` | n | Tab mới |
| `<leader>tx` | n | Đóng tab |
| `<leader>tn` `<leader>tp` | n | Tab sau / trước |
| `<leader>tf` | n | Đưa file hiện tại sang tab mới |
| `gt` `gT` | n | Tab sau / trước (built-in) |

---

## 5. Buffer & Bufferline

| Phím | Mode | Việc |
|------|------|------|
| `<S-l>` `<S-h>` | n | Buffer sau / trước |
| `<leader>b1` `b2` `b3` | n | Nhảy tới buffer 1 / 2 / 3 |
| `<leader>bd` | n | Đóng buffer hiện tại |
| `<leader>bo` | n | Đóng các buffer khác |
| `<leader>bp` | n | Ghim buffer |

---

## 6. File Explorer (neo-tree)

| Phím | Mode | Việc |
|------|------|------|
| `<leader>e` | n | Bật/tắt cây thư mục |
| `l` | (trong tree) | Mở file / mở rộng folder |
| `h` | (trong tree) | Đóng folder |
| `s` `S` | (trong tree) | Mở ở split dọc / ngang |
| `t` | (trong tree) | Mở ở tab mới |
| `a` `d` `r` `m` | (trong tree) | Thêm / xoá / đổi tên / di chuyển |
| `H` | (trong tree) | Bật/tắt file ẩn |
| `/` | (trong tree) | Lọc nhanh |
| `q` | (trong tree) | Đóng |

---

## 7. Tìm kiếm (Telescope)

| Phím | Mode | Việc |
|------|------|------|
| `<leader>ff` | n | Tìm file theo tên |
| `<leader>fg` | n | Tìm theo nội dung (live grep) |
| `<leader>fw` | n | Tìm từ dưới con trỏ |
| `<leader>fr` | n | File mở gần đây |
| `<leader>fb` | n | Danh sách buffer |
| `<leader>fd` | n | Danh sách lỗi (diagnostics) |
| `<leader>fs` | n | Symbol trong file |
| `<leader>fh` | n | Trang help |
| `<leader>fk` | n | Danh sách keymap |
| `<C-j>` `<C-k>` | (trong picker) | Xuống / lên |
| `<C-v>` `<C-x>` `<C-t>` | (trong picker) | Mở ở vsplit / split / tab |
| `<C-q>` | (trong picker) | Đưa kết quả vào quickfix |

---

## 8. Harpoon (ghim file)

| Phím | Mode | Việc |
|------|------|------|
| `<leader>a` | n | Ghim file hiện tại |
| `<C-e>` | n | Mở menu harpoon |
| `<leader>1` … `<leader>4` | n | Nhảy tới file ghim 1–4 |
| `[h` `]h` | n | File ghim trước / sau |

---

## 9. LSP (code intelligence)

| Phím | Mode | Việc |
|------|------|------|
| `gd` | n | Tới định nghĩa |
| `gD` | n | Tới khai báo |
| `gi` | n | Tới implementation |
| `gr` | n | Xem mọi nơi dùng (references) |
| `K` | n | Xem docs / kiểu dữ liệu |
| `<leader>rn` | n | Đổi tên toàn project |
| `<leader>ca` | n | Code action (sửa nhanh / import) |
| `<leader>D` | n | Tới type definition |
| `<leader>ih` | n | Bật/tắt inlay hints |

---

## 10. Completion (khi gõ code)

| Phím | Mode | Việc |
|------|------|------|
| `<C-Space>` | i | Gọi gợi ý thủ công |
| `<Tab>` `<S-Tab>` | i | Xuống / lên trong menu (hoặc nhảy snippet) |
| `<C-n>` `<C-p>` | i | Xuống / lên trong menu |
| `<CR>` | i | Chọn gợi ý |
| `<C-e>` | i | Đóng menu |
| `<C-f>` `<C-b>` | i | Cuộn ô docs |

---

## 11. Chỉnh sửa nâng cao

### Text object theo cấu trúc code (treesitter)
| Phím | Mode | Việc |
|------|------|------|
| `af` / `if` | o/v | Cả hàm / thân hàm |
| `ac` / `ic` | o/v | Cả class-struct / bên trong |
| `aa` / `ia` | o/v | Cả tham số / bên trong |

Ví dụ: `cif` đổi thân hàm · `daf` xoá cả hàm · `via` chọn 1 tham số.

### Surround (nvim-surround)
| Phím | Mode | Việc |
|------|------|------|
| `ys<motion><char>` | n | Bọc: `ysiw"` bọc từ trong `"` |
| `cs<old><new>` | n | Đổi: `cs"'` đổi `"` thành `'` |
| `ds<char>` | n | Xoá cặp: `ds(` xoá `()` |
| `S<char>` | v | Bọc vùng đang chọn |

---

## 12. Format & Lint

| Phím | Mode | Việc |
|------|------|------|
| `<leader>cf` | n/v | Format file / vùng chọn |
| *(tự động)* | — | Format khi lưu (`:w`) |
| *(tự động)* | — | Lint khi lưu / rời insert |

---

## 13. Diagnostics & Trouble

| Phím | Mode | Việc |
|------|------|------|
| `]d` `[d` | n | Lỗi tiếp / trước |
| `<leader>dl` | n | Xem lỗi tại dòng |
| `<leader>xx` | n | Danh sách toàn bộ lỗi (Trouble) |
| `<leader>xX` | n | Lỗi trong buffer này |
| `<leader>xs` | n | Symbol (Trouble) |
| `<leader>xl` `<leader>xq` | n | Location list / Quickfix |

---

## 14. Git

| Phím | Mode | Việc |
|------|------|------|
| `]c` `[c` | n | Thay đổi (hunk) tiếp / trước |
| `<leader>hp` | n | Xem trước hunk |
| `<leader>hs` | n | Stage hunk |
| `<leader>hr` | n | Hoàn tác hunk |
| `<leader>hb` | n | Blame dòng (ai sửa) |
| `<leader>gd` | n | Diffview: xem thay đổi |
| `<leader>gh` | n | Diffview: lịch sử file |
| `<leader>gc` | n | Diffview: đóng |
| `<leader>gg` | n | Mở **lazygit** |

---

## 15. Test (neotest)

> Dùng `<leader>T` (chữ HOA) để không đè `<leader>t` (tab/terminal).

| Phím | Mode | Việc |
|------|------|------|
| `<leader>Tr` | n | Chạy test gần con trỏ |
| `<leader>Tf` | n | Chạy cả file |
| `<leader>Td` | n | Debug test (cần DAP) |
| `<leader>Ts` | n | Bảng tổng kết |
| `<leader>To` | n | Xem output |
| `<leader>TS` | n | Dừng test |

---

## 16. Terminal

| Phím | Mode | Việc |
|------|------|------|
| `<C-\>` | n/t | Bật/tắt terminal nổi (toggleterm) |
| `<leader>gg` | n | Lazygit toàn màn hình |
| `<leader>th` `<leader>tv` | n | Terminal split ngang / dọc (built-in) |
| `<Esc><Esc>` | t | Về normal mode trong terminal |

---

## 17. Vim thuần — nền tảng phải nhớ

> Không cần plugin. Đây là thứ dùng nhiều nhất khi code.

### Text object cơ bản (`i` = inner, `a` = around)
| Phím | Việc |
|------|------|
| `ciw` | Đổi từ đang đứng |
| `ci"` `ci'` `ci\`` | Đổi trong nháy |
| `ci(` `ci{` `ci[` | Đổi trong ngoặc |
| `cit` | Đổi trong thẻ HTML/JSX |
| `dap` | Xoá cả đoạn |
| `dt,` `ct)` | Xoá / đổi **tới** ký tự `,` `)` |

### Power moves
| Phím | Việc |
|------|------|
| `.` | Lặp lại thao tác vừa rồi |
| `qa` … `q` → `@a` | Ghi / phát macro (`@@` lặp) |
| `<C-a>` `<C-x>` | Tăng / giảm số dưới con trỏ |
| `>>` `<<` `==` | Thụt lề phải / trái / tự động |
| `J` | Nối dòng dưới lên |
| `gv` | Chọn lại vùng vừa bôi đen |
| `ddp` `xp` | Đảo 2 dòng / 2 ký tự |

### Insert mode
| Phím | Việc |
|------|------|
| `<C-w>` | Xoá từ phía trước |
| `<C-u>` | Xoá cả dòng đang gõ |
| `<C-o>` + lệnh | Chạy 1 lệnh normal rồi quay lại insert |
