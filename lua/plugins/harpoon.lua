return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- bản mới, API sạch hơn
  dependencies = { "nvim-lua/plenary.nvim" },
  -- Nạp khi bấm 1 trong các phím dưới, thay vì load ngay lúc mở nvim
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

    -- Ghim file hiện tại vào danh sách
    map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: ghim file" })

    -- Mở menu xem/sắp xếp các file đã ghim
    map("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon: menu" })

    -- Nhảy tới file đã ghim thứ 1..4
    map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: file 1" })
    map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: file 2" })
    map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: file 3" })
    map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: file 4" })

    -- Nhảy tới file ghim trước / sau trong danh sách
    map("n", "[h", function() harpoon:list():prev() end, { desc = "Harpoon: file trước" })
    map("n", "]h", function() harpoon:list():next() end, { desc = "Harpoon: file sau" })
  end,
}
