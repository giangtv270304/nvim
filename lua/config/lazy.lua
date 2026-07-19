-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim + LazyVim
require("lazy").setup({
  spec = {
    -- LazyVim core + its default plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- LazyVim extras (phải nằm sau lazyvim.plugins, trước plugins của mình)
    { import = "lazyvim.plugins.extras.vscode" },
    -- import/override with your own plugins
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "gruvbox", "habamax" } },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})

-- Nạp hết toàn bộ plugin ngay khi mở nvim (kể cả những plugin lazy-load
-- theo event/keys/cmd/ft), tránh tình trạng phải "dùng thử" một phím/lệnh
-- lần đầu thì plugin mới được load. Tương đương lệnh `:Lazy load all`.
-- Đánh đổi: thời gian khởi động lâu hơn một chút.
--
-- Trong terminal thật: nạp TỪNG plugin một qua vim.schedule (thay vì gọi
-- 1 lần cho tất cả) để redraw được giữa mỗi bước -> hiện được tiến trình
-- loading (giống splash screen) thay vì màn hình đứng im rồi bật hết 1 lúc.
-- Trong VSCode: giữ lối nạp gộp cũ, không hiện tiến trình - vim.notify ở đó
-- là popup thật của VSCode (không tự cập nhật tại chỗ), nạp từng cái một
-- sẽ tạo ra hàng chục popup dồn dập rất khó chịu.
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.schedule(function()
      local lazy = require("lazy")
      local names = vim.tbl_keys(require("lazy.core.config").plugins)

      if vim.g.vscode then
        lazy.load({ plugins = names })
        return
      end

      -- nạp snacks.nvim trước để các thông báo tiến trình phía sau hiện
      -- đẹp qua Snacks.notifier thay vì message mặc định của Nvim
      pcall(function() lazy.load({ plugins = { "snacks.nvim" } }) end)

      table.sort(names)
      local total = #names
      local start = (vim.uv or vim.loop).hrtime()
      local i = 0

      local function step()
        i = i + 1
        local name = names[i]
        if not name then
          local ms = math.floor(((vim.uv or vim.loop).hrtime() - start) / 1e6)
          vim.notify(
            string.format("Đã tải xong %d plugin (%dms)", total, ms),
            vim.log.levels.INFO,
            { id = "cfg_loading", title = "Nạp cấu hình", timeout = 1000 }
          )
          return
        end
        vim.notify(
          string.format("Đang tải cấu hình... (%d/%d) %s", i, total, name),
          vim.log.levels.INFO,
          { id = "cfg_loading", title = "Nạp cấu hình", timeout = false }
        )
        pcall(function() lazy.load({ plugins = { name } }) end)
        vim.schedule(step)
      end
      step()
    end)
  end,
})
