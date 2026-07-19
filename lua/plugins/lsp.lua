return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/nvim-cmp", -- nạp cùng lúc với LSP để tránh race "module 'cmp' not found"
    "hrsh7th/cmp-nvim-lsp",
    "b0o/SchemaStore.nvim", -- schema JSON/YAML (k8s, github actions, compose...)
  },
  config = function()
    require("mason").setup()

    -- Capabilities chung: báo cho mọi server biết nvim-cmp làm được gì
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("*", { capabilities = capabilities })

    -- ===== Cấu hình riêng từng server =====
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

    -- ===== LSP server cần cài (mason tự tải) =====
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",       -- Lua (config nvim)
        "gopls",        -- Go
        "ts_ls",        -- JavaScript / TypeScript
        "eslint",       -- lint JS/TS qua LSP
        "ansiblels",    -- Ansible
        "terraformls",  -- Terraform / Terragrunt (HCL)
        "dockerls",     -- Dockerfile
        "docker_compose_language_service", -- docker-compose
        "yamlls",       -- YAML (k8s, ci, ansible schema)
        "bashls",       -- Bash / shell
        "jsonls",       -- JSON
        "marksman",     -- Markdown
      },
    })

    -- ===== Formatter + linter cài qua mason =====
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua",       -- format Lua
        "goimports",    -- format + sắp xếp import Go
        "gofumpt",      -- format Go nghiêm hơn
        "prettierd",    -- format js/ts/json/yaml/md (nhanh)
        "prettier",     -- fallback nếu prettierd lỗi
        "shfmt",        -- format shell
        "shellcheck",   -- lint shell
        "hadolint",     -- lint Dockerfile
        "ansible-lint", -- lint Ansible
        "tflint",       -- lint Terraform
      },
    })

    -- ===== Phím tắt khi 1 server gắn vào buffer =====
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
