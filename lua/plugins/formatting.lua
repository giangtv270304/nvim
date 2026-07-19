return {
  "stevearc/conform.nvim",
  -- KHÔNG set `config` ở đây: LazyVim tự gán `config = M.setup` cho
  -- conform.nvim (lazyvim/plugins/formatting.lua) để tích hợp autoformat
  -- toggle (<leader>uf/<leader>uF) và LazyVim.format registry. Đè `config`
  -- sẽ bị LazyVim cảnh báo "Don't set plugin.config" và phá format-on-save.
  -- Chỉ mở rộng `opts.formatters_by_ft` - opts nhận vào đã có sẵn default
  -- của LazyVim (lua, fish, sh) và được merge chứ không bị thay thế.
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
  -- Không cần tự map <leader>cf: LazyVim đã map sẵn (n + x mode) gọi
  -- LazyVim.format({force=true}) qua format registry, tự tích hợp toggle
  -- autoformat - map lại ở đây chỉ để trùng và bỏ qua force/registry.
}
