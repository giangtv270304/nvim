# ⌨️ Neovim Keymaps Cheat-Sheet

> `<leader>` = **Space**. Convention: `<C-x>` = Ctrl+x, `<S-x>` = Shift+x, `<A-x>` = Alt+x.
> **Mode** column: `n` normal · `i` insert · `v` visual · `t` terminal · `o` operator-pending.

## 📑 Table of contents

1. [Basics (save / quit / search)](#1-basics)
2. [Fast movement](#2-fast-movement)
3. [Windows & splits](#3-windows--splits)
4. [Tabs](#4-tabs)
5. [Buffers & bufferline](#5-buffers--bufferline)
6. [File explorer (neo-tree)](#6-file-explorer-neo-tree)
7. [Search (Telescope)](#7-search-telescope)
8. [Harpoon (pin files)](#8-harpoon-pin-files)
9. [LSP (code intelligence)](#9-lsp-code-intelligence)
10. [Completion (while typing)](#10-completion-while-typing)
11. [Advanced editing (text objects, surround)](#11-advanced-editing)
12. [Format & lint](#12-format--lint)
13. [Diagnostics & Trouble](#13-diagnostics--trouble)
14. [Git](#14-git)
15. [Test (neotest)](#15-test-neotest)
16. [Terminal](#16-terminal)
17. [Plain Vim — the fundamentals to know by heart](#17-plain-vim--fundamentals)
18. [Database (vim-dadbod)](#18-database-vim-dadbod)

---

## 1. Basics

| Key | Mode | Action |
|------|------|------|
| `<leader>w` | n | Save file |
| `<leader>q` | n | Quit window |
| `<Esc>` | n | Clear search highlight |
| `/` … `n` `N` | n | Search in file · next/previous match |
| `<C-d>` `<C-u>` | n | Scroll half page (cursor stays centered) |

---

## 2. Fast movement

| Key | Mode | Action |
|------|------|------|
| `s` + 2 chars | n/v/o | **Flash**: jump anywhere on screen |
| `S` | n/v/o | **Flash**: jump by Treesitter node |
| `f<c>` `t<c>` | n | Jump to / before char `c` on the line (`;` `,` repeat) |
| `%` | n | Jump to matching bracket |
| `*` `#` | n | Jump to word under cursor (next / previous) |
| `{` `}` | n | Jump by paragraph |
| `<C-o>` `<C-i>` | n | Jump back / forward in the jumplist |
| `]f` `[f` | n | Next / previous function |
| `]C` `[C` | n | Next / previous class/struct |

---

## 3. Windows & splits

| Key | Mode | Action |
|------|------|------|
| `<leader>sv` | n | Split vertically |
| `<leader>sh` | n | Split horizontally |
| `<leader>se` | n | Equalize split sizes |
| `<leader>sx` | n | Close current split |
| `<leader>so` | n | Close all other splits |
| `<C-h/j/k/l>` | n | Move between splits |
| `<C-↑/↓/←/→>` | n | Resize split |

---

## 4. Tabs

| Key | Mode | Action |
|------|------|------|
| `<leader>to` | n | New tab |
| `<leader>tx` | n | Close tab |
| `<leader>tn` `<leader>tp` | n | Next / previous tab |
| `<leader>tf` | n | Move current file to a new tab |
| `gt` `gT` | n | Next / previous tab (built-in) |

---

## 5. Buffers & bufferline

| Key | Mode | Action |
|------|------|------|
| `<S-l>` `<S-h>` | n | Next / previous buffer |
| `<leader>b1` `b2` `b3` | n | Jump to buffer 1 / 2 / 3 |
| `<leader>bd` | n | Close current buffer |
| `<leader>bo` | n | Close other buffers |
| `<leader>bp` | n | Pin buffer |

---

## 6. File explorer (neo-tree)

| Key | Mode | Action |
|------|------|------|
| `<leader>e` | n | Toggle file tree |
| `l` | (in tree) | Open file / expand folder |
| `h` | (in tree) | Collapse folder |
| `s` `S` | (in tree) | Open in vertical / horizontal split |
| `t` | (in tree) | Open in a new tab |
| `a` `d` `r` `m` | (in tree) | Add / delete / rename / move |
| `H` | (in tree) | Toggle hidden files |
| `/` | (in tree) | Quick filter |
| `q` | (in tree) | Close |

---

## 7. Search (Telescope)

| Key | Mode | Action |
|------|------|------|
| `<leader>ff` | n | Find files by name |
| `<leader>fg` | n | Search file contents (live grep) |
| `<leader>fw` | n | Search word under cursor |
| `<leader>fr` | n | Recently opened files |
| `<leader>fb` | n | List buffers |
| `<leader>fd` | n | List diagnostics |
| `<leader>fs` | n | Symbols in current file |
| `<leader>fh` | n | Help pages |
| `<leader>fk` | n | List keymaps |
| `<C-j>` `<C-k>` | (in picker) | Move selection down / up |
| `<C-v>` `<C-x>` `<C-t>` | (in picker) | Open in vsplit / split / tab |
| `<C-q>` | (in picker) | Send results to quickfix list |

---

## 8. Harpoon (pin files)

| Key | Mode | Action |
|------|------|------|
| `<leader>a` | n | Pin current file |
| `<C-e>` | n | Open Harpoon menu |
| `<leader>1` … `<leader>4` | n | Jump to pinned file 1–4 |
| `[h` `]h` | n | Previous / next pinned file |

---

## 9. LSP (code intelligence)

| Key | Mode | Action |
|------|------|------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gi` | n | Go to implementation |
| `gr` | n | List references |
| `K` | n | Show hover docs / type info |
| `<leader>rn` | n | Rename across the project |
| `<leader>ca` | n | Code action (quick fix / add import) |
| `<leader>D` | n | Go to type definition |
| `<leader>ih` | n | Toggle inlay hints |

---

## 10. Completion (while typing)

| Key | Mode | Action |
|------|------|------|
| `<C-Space>` | i | Trigger completion manually |
| `<Tab>` `<S-Tab>` | i | Next / previous item in menu (or jump snippet placeholder) |
| `<C-n>` `<C-p>` | i | Next / previous item in menu |
| `<CR>` | i | Confirm selection |
| `<C-e>` | i | Close menu |
| `<C-f>` `<C-b>` | i | Scroll the docs popup |

---

## 11. Advanced editing

### Structure-aware text objects (Treesitter)
| Key | Mode | Action |
|------|------|------|
| `af` / `if` | o/v | Around / inner function |
| `ac` / `ic` | o/v | Around / inner class-struct |
| `aa` / `ia` | o/v | Around / inner parameter |

Examples: `cif` changes the function body · `daf` deletes the whole function ·
`via` selects one parameter.

### Surround (nvim-surround)
| Key | Mode | Action |
|------|------|------|
| `ys<motion><char>` | n | Add surround: `ysiw"` wraps the word in `"` |
| `cs<old><new>` | n | Change surround: `cs"'` turns `"` into `'` |
| `ds<char>` | n | Delete surround: `ds(` removes `()` |
| `S<char>` | v | Surround the current selection |

---

## 12. Format & lint

| Key | Mode | Action |
|------|------|------|
| `<leader>cf` | n/v | Format file / selection |
| *(automatic)* | — | Format on save (`:w`) |
| *(automatic)* | — | Lint on save / on leaving insert mode |

---

## 13. Diagnostics & Trouble

| Key | Mode | Action |
|------|------|------|
| `]d` `[d` | n | Next / previous diagnostic |
| `<leader>dl` | n | Show diagnostics for current line |
| `<leader>xx` | n | List all diagnostics (Trouble) |
| `<leader>xX` | n | Diagnostics for current buffer |
| `<leader>xs` | n | Symbols (Trouble) |
| `<leader>xl` `<leader>xq` | n | Location list / quickfix list |

---

## 14. Git

| Key | Mode | Action |
|------|------|------|
| `]c` `[c` | n | Next / previous hunk |
| `<leader>hp` | n | Preview hunk |
| `<leader>hs` | n | Stage hunk |
| `<leader>hr` | n | Reset hunk |
| `<leader>hb` | n | Blame line |
| `<leader>gd` | n | Diffview: view changes |
| `<leader>gh` | n | Diffview: file history |
| `<leader>gc` | n | Diffview: close |
| `<leader>gg` | n | Open **lazygit** |

---

## 15. Test (neotest)

> Uses `<leader>T` (capital T) so it doesn't collide with `<leader>t` (tab/terminal).

| Key | Mode | Action |
|------|------|------|
| `<leader>Tr` | n | Run nearest test |
| `<leader>Tf` | n | Run whole file |
| `<leader>Td` | n | Debug test (requires DAP) |
| `<leader>Ts` | n | Summary panel |
| `<leader>To` | n | View output |
| `<leader>TS` | n | Stop test |

---

## 16. Terminal

| Key | Mode | Action |
|------|------|------|
| `<C-\>` | n/t | Toggle floating terminal (toggleterm) |
| `<leader>gg` | n | Lazygit, full screen |
| `<leader>th` `<leader>tv` | n | Horizontal / vertical terminal split (built-in) |
| `<Esc><Esc>` | t | Back to normal mode inside a terminal |

---

## 17. Plain Vim — fundamentals

> No plugin needed. This is what you'll use the most while coding.

### Basic text objects (`i` = inner, `a` = around)
| Key | Action |
|------|------|
| `ciw` | Change word under cursor |
| `ci"` `ci'` `` ci` `` | Change inside quotes |
| `ci(` `ci{` `ci[` | Change inside brackets |
| `cit` | Change inside an HTML/JSX tag |
| `dap` | Delete whole paragraph |
| `dt,` `ct)` | Delete / change **up to** char `,` `)` |

### Power moves
| Key | Action |
|------|------|
| `.` | Repeat last change |
| `qa` … `q` → `@a` | Record / play macro (`@@` repeats it) |
| `<C-a>` `<C-x>` | Increment / decrement number under cursor |
| `>>` `<<` `==` | Indent right / left / auto-indent |
| `J` | Join line below onto current line |
| `gv` | Reselect last visual selection |
| `ddp` `xp` | Swap two lines / two characters |

### Insert mode
| Key | Action |
|------|------|
| `<C-w>` | Delete word before cursor |
| `<C-u>` | Delete whole line being typed |
| `<C-o>` + command | Run one normal-mode command, then return to insert |

---

## 18. Database (vim-dadbod)

| Key | Mode | Action |
|------|------|------|
| `<leader>Du` | n | Toggle the DB UI sidebar (browse connections/tables) |
| `<leader>Da` | n | Add a new DB connection |
| `<leader>Df` | n | Find/jump to the query buffer for the current connection |

No connections are pre-configured — add yours with `<leader>Da` (`:DBUIAddConnection`), which
saves them under `g:db_ui_save_location` (not committed to git).

Once a `.sql` buffer is connected to a database (via the DB UI or `b:db`), typing table/column
names triggers completion automatically (vim-dadbod-completion). To run a query, select it in
visual mode and use the DB UI's default execute mapping (`<Leader>S` in a query buffer opened
through `:DBUIToggle` — see `:help db_ui-mappings` for the full list).
