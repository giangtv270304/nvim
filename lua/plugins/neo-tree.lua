return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Neo-tree" },
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		if vim.fn.argc(-1) == 1 then
			local stat = vim.uv.fs_stat(vim.fn.argv(0))
			if stat and stat.type == "directory" then
				require("lazy").load({ plugins = { "neo-tree.nvim" } })
			end
		end
	end,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				mappings = {
					["l"] = "open", -- l: mở file / mở rộng folder
					["h"] = "close_node", -- h: đóng folder
					["<space>"] = "none", -- bỏ toggle của Space để không đè phím leader
				},
			},
			filesystem = {
				hijack_netrw_behavior = "open_default", -- mở dạng sidebar bên trái
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
		})
	end,
}
