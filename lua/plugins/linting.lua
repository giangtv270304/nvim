return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Linters not covered by LSP (ESLint/gopls already handle their own languages)
    lint.linters_by_ft = {
      dockerfile = { "hadolint" },
      ["yaml.ansible"] = { "ansible_lint" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
    }

    -- Deliberately not on InsertLeave: shellcheck/ansible-lint are external
    -- processes that would respawn on every <Esc> out of insert mode, causing
    -- stutter while editing sh/ansible files. Only lint on save or on open.
    local group = vim.api.nvim_create_augroup("nvim_lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      group = group,
      callback = function()
        -- only lint editable buffers (skip help, readonly, etc.)
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
}
