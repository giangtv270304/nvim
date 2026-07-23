return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/nvim-cmp", -- load alongside LSP to avoid a "module 'cmp' not found" race
    "hrsh7th/cmp-nvim-lsp",
    "b0o/SchemaStore.nvim", -- JSON/YAML schemas (k8s, GitHub Actions, compose...)
  },
  config = function()
    require("mason").setup()

    -- Shared capabilities: tell every server what nvim-cmp supports
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("*", { capabilities = capabilities })

    -- ===== Per-server config =====
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          gofumpt = true,
          staticcheck = true,
          analyses = {
            unusedparams = true,
            nilness = true,
            unusedwrite = true,
            useany = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          schemaStore = { enable = false, url = "" },
          schemas = require("schemastore").yaml.schemas(),
          keyOrdering = false,
          validate = true,
        },
      },
    })

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    -- terragrunt.hcl is filetype "hcl" (not "terraform"), so add it here or
    -- terraform-ls / tflint (auto-enabled by mason-lspconfig since the
    -- tflint binary is installed) never attach to Terragrunt files.
    vim.lsp.config("terraformls", {
      filetypes = { "terraform", "terraform-vars", "hcl" },
    })
    vim.lsp.config("tflint", {
      filetypes = { "terraform", "hcl" },
    })

    -- ===== LSP servers to install (Mason installs these automatically) =====
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",       -- Lua (this config)
        "gopls",        -- Go
        "ts_ls",        -- JavaScript / TypeScript
        "eslint",       -- lint JS/TS via LSP
        "ansiblels",    -- Ansible
        "terraformls",  -- Terraform / Terragrunt (HCL)
        "dockerls",     -- Dockerfile
        "docker_compose_language_service", -- docker-compose
        "yamlls",       -- YAML (k8s, CI, Ansible schemas)
        "bashls",       -- Bash / shell
        "jsonls",       -- JSON
        "marksman",     -- Markdown
      },
    })

    -- ===== Formatters + linters installed via Mason =====
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua",       -- format Lua
        "goimports",    -- format + sort Go imports
        "gofumpt",      -- stricter Go formatting
        "prettierd",    -- format js/ts/json/yaml/md (fast)
        "prettier",     -- fallback if prettierd fails
        "shfmt",        -- format shell
        "shellcheck",   -- lint shell
        "hadolint",     -- lint Dockerfile
        "ansible-lint", -- lint Ansible
        "tflint",       -- lint Terraform
      },
    })

    -- ===== Keymaps applied when a server attaches to a buffer =====
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
      callback = function(ev)
        local function map(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Goto definition")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("gi", vim.lsp.buf.implementation, "Goto implementation")
        map("gr", vim.lsp.buf.references, "References")
        map("K", vim.lsp.buf.hover, "Hover docs")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
      end,
    })
  end,
}
