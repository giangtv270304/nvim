return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- fast sorting (needs a C compiler)
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Telescope",
  -- Load on first use of one of these keys instead of at startup
  keys = {
    "<leader>ff",
    "<leader>fg",
    "<leader>fb",
    "<leader>fh",
    "<leader>fr",
    "<leader>fw",
    "<leader>fd",
    "<leader>fs",
    "<leader>fk",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        file_ignore_patterns = { "node_modules", "%.git/", "%.terraform/", "vendor/", "%.terragrunt%-cache/" },
        -- The "main" branch of nvim-treesitter (which LazyVim uses) dropped the
        -- old API Telescope's previewer needs (`nvim-treesitter.parsers.get_parser`)
        -- -> disable it to avoid crashing on preview; the buffer preview still
        -- gets highlighted via plain :syntax.
        preview = { treesitter = false },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })
    pcall(telescope.load_extension, "fzf")

    local builtin = require("telescope.builtin")
    local map = vim.keymap.set
    map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
    map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
    map("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })
    map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
    map("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
    map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
  end,
}
