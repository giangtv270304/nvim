return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		priority = 1000, -- nạp trước mọi plugin khác (là colorscheme)
	},
	{
		-- Đang thử scheme này thay cho gruvbox.nvim - https://github.com/eddyekofo94/gruvbox-flat.nvim
		"eddyekofo94/gruvbox-flat.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		-- :colorscheme kanagawa-wave | kanagawa-dragon | kanagawa-lotus
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		-- :colorscheme catppuccin-latte | catppuccin-frappe | catppuccin-macchiato | catppuccin-mocha
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 1000,
	},
	{
		-- :colorscheme onedark
		"navarasu/onedark.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				require("gruvbox").setup({
					contrast = "medium", -- tone Gruvbox Medium
					transparent_mode = true, -- trong suốt ĐÚNG CÁCH (giữ màu chữ, chỉ bỏ nền)
				})
				vim.o.background = "dark"
				vim.cmd.colorscheme("gruvbox")
			end,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "gruvbox",
				globalstatus = true, -- 1 statusline chung cho mọi split
				-- Không set section_separators/component_separators để dùng mặc định của lualine ( / )
			},
		},
	},
}
