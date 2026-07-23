-- Force LazyVim to use the pickers/completion I've configured manually instead
-- of silently switching to its newer defaults (blink.cmp / snacks explorer /
-- snacks picker). This file loads AFTER lazyvim.config.options, which is why
-- it can override them.
vim.g.lazyvim_cmp = "nvim-cmp"
vim.g.lazyvim_explorer = "neo-tree"
vim.g.lazyvim_picker = "telescope"

-- Neovim only detects *.tf as filetype "terraform" once the file has a
-- non-blank line (it's disambiguating from TinyFugue's old "tf" config
-- format). A brand-new empty .tf buffer falls back to "tf", so LSP/format/
-- treesitter never attach until the file is saved with content and reopened.
-- Force it unconditionally since nobody edits TinyFugue configs anymore.
vim.filetype.add({ extension = { tf = "terraform" } })

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- Indentation: 2 spaces is the standard for yaml/terraform/js/ts/ansible
-- (Go uses real tabs — handled separately in autocmds.lua)
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI
opt.list = false -- LazyVim enables this by default, which shows a ">" glyph for real tabs
opt.termguicolors = true
opt.signcolumn = "yes" -- always reserve the sign column so git/diagnostic signs don't shift the layout
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.pumheight = 10

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Files / undo
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undolevels = 10000

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 250 -- faster response for hover, gitsigns, etc.
opt.timeoutlen = 400 -- time to wait for the next key in a leader/which-key sequence
-- Deliberately NOT inherited from timeoutlen (default -1): without setting this
-- separately, every <Esc> to leave insert mode stalls up to 400ms because Nvim
-- waits to see if more bytes are coming (Alt/F-key escape sequences over the
-- terminal). Splitting it out makes <Esc> feel instant.
opt.ttimeoutlen = 10
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true -- ask to save instead of erroring out on :q with unsaved changes

opt.mousescroll = "ver:1,hor:0" -- 1 line per wheel notch instead of the default 3,
-- matches snacks.nvim's smooth-scroll animation (enabled by LazyVim, see
-- lazyvim/plugins/ui.lua scroll.enabled=true)
vim.g.loaded_matchparen = 1 -- disable matching-bracket highlight: one less thing to
-- recompute on every cursor move, keeps typing/movement smoother

-- Diagnostics UI
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
