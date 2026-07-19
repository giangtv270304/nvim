return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end
			-- Nhảy giữa các đoạn thay đổi (hunk)
			map("n", "]c", gs.next_hunk, "Next git hunk")
			map("n", "[c", gs.prev_hunk, "Prev git hunk")
			-- Xem / stage / hoàn tác một hunk
			map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			-- Xem ai sửa dòng này (git blame)
			map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
		end,
	},
}
