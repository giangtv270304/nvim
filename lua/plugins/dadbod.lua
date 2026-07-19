return {
  {
    "tpope/vim-dadbod",
    lazy = true,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>Du", "<cmd>DBUIToggle<CR>", desc = "Toggle DB UI" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<CR>", desc = "Find DB buffer" },
      { "<leader>Da", "<cmd>DBUIAddConnection<CR>", desc = "Add DB connection" },
    },
    init = function()
      -- No connections are pre-configured here on purpose (keeps credentials
      -- out of git). Add yours with <leader>Da, or set `vim.g.dbs` in a
      -- git-ignored local file if you want them versioned privately.
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod", "hrsh7th/nvim-cmp" },
    config = function()
      -- Layer the DB-aware source on top of the usual buffer/path sources
      -- for any SQL-flavored buffer connected to a database (b:db set by
      -- vim-dadbod-ui or manually).
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          require("cmp").setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
              { name = "path" },
            },
          })
        end,
      })
    end,
  },
}
