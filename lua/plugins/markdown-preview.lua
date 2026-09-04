-- Live browser preview for markdown (real HTML/CSS, unlike render-markdown.nvim's
-- in-buffer approximation). Not useful inside VSCode, which has its own preview.
if vim.g.vscode then
  return {}
end

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  -- Not mkdp#util#install(): with ft/cmd lazy-loading, that Vim function
  -- isn't sourced yet when :Lazy runs build (E117). Must be `npm
  -- --no-package-lock`, not `yarn install`: this app ships a classic-yarn
  -- `yarn.lock`, and both plain npm and modern Yarn Berry rewrite it,
  -- leaving a dirty git tree that blocks future `:Lazy sync`. Also installs
  -- `msgpack-lite` into a scratch dir and copies it in: the server requires
  -- it directly but it's missing from package.json (only in yarn.lock), so
  -- without this the preview server crashes with MODULE_NOT_FOUND.
  build = function()
    local app_dir = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"
    vim.fn.system({ "npm", "install", "--no-package-lock" , "--prefix", app_dir })
    if vim.fn.isdirectory(app_dir .. "/node_modules/msgpack-lite") == 0 then
      local scratch = vim.fn.tempname()
      vim.fn.mkdir(scratch, "p")
      vim.fn.system({ "npm", "install", "msgpack-lite", "--no-package-lock", "--prefix", scratch })
      vim.fn.system({ "sh", "-c", "cp -r " .. vim.fn.shellescape(scratch) .. "/node_modules/* "
        .. vim.fn.shellescape(app_dir) .. "/node_modules/" })
      vim.fn.delete(scratch, "rf")
    end
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_auto_close = false
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown: preview in browser", ft = "markdown" },
  },
}
