return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- newer branch, cleaner API
  dependencies = { "nvim-lua/plenary.nvim" },
  -- Load on first use of one of these keys instead of at startup
  keys = {
    "<leader>a",
    "<C-e>",
    "<leader>1",
    "<leader>2",
    "<leader>3",
    "<leader>4",
    "[h",
    "]h",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local map = vim.keymap.set

    -- Pin the current file to the list
    map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: pin file" })

    -- Open the menu to view/reorder pinned files
    map("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon: menu" })

    -- Jump to pinned file 1..4
    map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: file 1" })
    map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: file 2" })
    map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: file 3" })
    map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: file 4" })

    -- Jump to the previous / next pinned file in the list
    map("n", "[h", function() harpoon:list():prev() end, { desc = "Harpoon: previous file" })
    map("n", "]h", function() harpoon:list():next() end, { desc = "Harpoon: next file" })
  end,
}
