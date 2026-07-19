return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Go
        "go", "gomod", "gosum", "gowork",
        -- JS / TS
        "javascript", "typescript", "tsx", "jsdoc",
        -- Data / config
        "json", "yaml", "toml",
        -- Infra
        "terraform", "hcl", "dockerfile",
        -- Git
        "gitignore", "git_config", "gitcommit",
      },
    },
  },
  {
    -- LazyVim mặc định đã bind sẵn "]f/[f" (move) theo API mới;
    -- ở đây chỉ bổ sung thêm các textobject "select" (vaf, vif, vac...)
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = {
      { "af", mode = { "x", "o" }, function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end, desc = "around function" },
      { "if", mode = { "x", "o" }, function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end, desc = "inner function" },
      { "ac", mode = { "x", "o" }, function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end, desc = "around class" },
      { "ic", mode = { "x", "o" }, function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end, desc = "inner class" },
      { "aa", mode = { "x", "o" }, function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects") end, desc = "around parameter" },
      { "ia", mode = { "x", "o" }, function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects") end, desc = "inner parameter" },
    },
  },
}
