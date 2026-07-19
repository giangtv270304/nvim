return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Linter không nằm trong LSP (ESLint/gopls đã lo phần của chúng)
    lint.linters_by_ft = {
      dockerfile = { "hadolint" },
      ["yaml.ansible"] = { "ansible_lint" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
    }

    -- Bỏ InsertLeave: shellcheck/ansible-lint là process ngoài, spawn lại mỗi
    -- lần thoát insert mode (tức mỗi lần bấm Esc) gây giật khi sửa sh/ansible.
    -- Giờ chỉ lint khi lưu file hoặc mở file.
    local group = vim.api.nvim_create_augroup("nvim_lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      group = group,
      callback = function()
        -- chỉ lint buffer sửa được (bỏ qua help, readonly...)
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
}
