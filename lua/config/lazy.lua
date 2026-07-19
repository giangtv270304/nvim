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
    -- LazyVim extras (must come after lazyvim.plugins, before our own plugins)
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

-- Force-load every plugin as soon as Neovim starts, including ones that would
-- otherwise lazy-load on event/keys/cmd/ft, so the first time you press a key
-- or run a command it's already ready (equivalent to `:Lazy load all`).
-- Trade-off: slightly longer startup time.
--
-- In a real terminal: load plugins one at a time via vim.schedule (instead of
-- all at once) so the screen can redraw between steps, showing loading
-- progress like a splash screen instead of freezing then popping everything
-- in at once. In VSCode: keep the old bulk-load behavior — vim.notify there
-- is a real VSCode popup that doesn't update in place, so loading one at a
-- time would spam dozens of popups.
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

      -- Load snacks.nvim first so the progress notifications below render
      -- nicely through Snacks.notifier instead of Nvim's default messages
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
            string.format("Loaded %d plugins (%dms)", total, ms),
            vim.log.levels.INFO,
            { id = "cfg_loading", title = "Loading config", timeout = 1000 }
          )
          return
        end
        vim.notify(
          string.format("Loading config... (%d/%d) %s", i, total, name),
          vim.log.levels.INFO,
          { id = "cfg_loading", title = "Loading config", timeout = false }
        )
        pcall(function() lazy.load({ plugins = { name } }) end)
        vim.schedule(step)
      end
      step()
    end)
  end,
})
