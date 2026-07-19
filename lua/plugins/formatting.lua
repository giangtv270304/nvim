return {
  "stevearc/conform.nvim",
  -- Don't set `config` here: LazyVim assigns `config = M.setup` itself for
  -- conform.nvim (lazyvim/plugins/formatting.lua) to wire up the autoformat
  -- toggle (<leader>uf/<leader>uF) and the LazyVim.format registry. Overriding
  -- `config` triggers LazyVim's "Don't set plugin.config" warning and breaks
  -- format-on-save. Only extend `opts.formatters_by_ft` — the incoming opts
  -- already has LazyVim's defaults (lua, fish, sh) and gets merged, not replaced.
  opts = function(_, opts)
    opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
      go = { "goimports", "gofumpt" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      ["yaml.ansible"] = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      sh = { "shfmt" },
      bash = { "shfmt" },
      terraform = { "terraform_fmt" },
      hcl = { "terraform_fmt" },
      ["terraform-vars"] = { "terraform_fmt" },
    })
  end,
  -- No need to map <leader>cf ourselves: LazyVim already maps it (normal + visual)
  -- to LazyVim.format({force=true}) through the format registry, with autoformat
  -- toggling built in — remapping it here would just shadow that and skip
  -- force/registry handling.
}
