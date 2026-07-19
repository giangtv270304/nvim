-- Autocommands & filetype detection
local augroup = function(name) return vim.api.nvim_create_augroup("cfg_" .. name, { clear = true }) end
local autocmd = vim.api.nvim_create_autocmd

-- Briefly flash the yanked region
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function() vim.hl.on_yank({ timeout = 200 }) end,
})

-- Go / Makefile need real tabs (gofmt and make require it)
autocmd("FileType", {
  group = augroup("tab_indent"),
  pattern = { "go", "gomod", "gowork", "make" },
  callback = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end,
})

-- Trim trailing whitespace on save (except markdown)
autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  callback = function()
    if vim.bo.filetype == "markdown" then return end
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- Filetype detection for the DevOps stack
vim.filetype.add({
  filename = {
    ["Dockerfile"] = "dockerfile",
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
    ["terragrunt.hcl"] = "hcl",
  },
  pattern = {
    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*%.ya?ml"] = "yaml.ansible",
    [".*/molecule/.*%.ya?ml"] = "yaml.ansible",
    ["playbook.*%.ya?ml"] = "yaml.ansible",
    [".*%.tftpl"] = "terraform",
  },
})
