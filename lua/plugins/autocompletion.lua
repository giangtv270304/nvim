return {
  "hrsh7th/nvim-cmp",
  -- Nạp cùng lúc mở file (giống nvim-lspconfig) thay vì đợi InsertEnter:
  -- cmp-nvim-lsp được require sớm ở lsp.lua và tự đăng ký 1 autocmd InsertEnter
  -- nội bộ đòi hỏi module 'cmp' phải có sẵn; nếu nvim-cmp còn đợi InsertEnter
  -- riêng thì 2 autocmd đua nhau, có lúc "module 'cmp' not found".
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- nguồn: LSP
    "hrsh7th/cmp-buffer",   -- nguồn: text trong buffer
    "hrsh7th/cmp-path",     -- nguồn: đường dẫn file
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" }, -- snippet dựng sẵn
    },
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Nạp snippet vscode-style (friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),          -- gọi gợi ý thủ công
        ["<C-e>"] = cmp.mapping.abort(),                 -- đóng menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter chọn
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),          -- cuộn ô docs
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- Tab: xuống menu / nhảy trong snippet
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
    })
  end,
}
