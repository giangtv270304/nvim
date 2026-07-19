return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end
			-- Jump between changed hunks
			map("n", "]c", gs.next_hunk, "Next git hunk")
			map("n", "[c", gs.prev_hunk, "Prev git hunk")
			-- Preview / stage / reset a hunk
			map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			-- See who last touched this line (git blame)
			map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
		end,
	},
}
