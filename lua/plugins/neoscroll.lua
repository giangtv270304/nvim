return {
	{
		-- Disable snacks.nvim's built-in smooth scroll while trying neoscroll instead
		"snacks.nvim",
		opts = {
			scroll = { enabled = false },
		},
	},
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		opts = {
			-- linear (default) barely reads as "smooth"; sine1 accelerates/decelerates
			easing = "sine1",
		},
		config = function(_, opts)
			require("neoscroll").setup(opts)

			-- Default mappings only cover keys (Ctrl-d/u/f/b, zt/zz/zb) — mouse/trackpad
			-- wheel scrolling isn't animated unless mapped explicitly, unlike snacks.nvim.
			local neoscroll = require("neoscroll")
			local wheel_opts = { move_cursor = false, duration = 100 }
			vim.keymap.set({ "n", "x" }, "<ScrollWheelDown>", function()
				neoscroll.scroll(3, wheel_opts)
			end)
			vim.keymap.set({ "n", "x" }, "<ScrollWheelUp>", function()
				neoscroll.scroll(-3, wheel_opts)
			end)
		end,
	},
}
