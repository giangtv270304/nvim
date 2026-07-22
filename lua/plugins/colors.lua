return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		priority = 1000, -- load before any other plugin (it's the colorscheme)
	},
	{
		-- Trying this out as an alternative to gruvbox.nvim - https://github.com/eddyekofo94/gruvbox-flat.nvim
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
					contrast = "medium", -- Gruvbox Medium tone
					transparent_mode = true, -- transparent background done right (keeps text colors, only drops the background)
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
				globalstatus = true, -- one shared statusline across all splits
				-- section_separators/component_separators left unset to use lualine's defaults ( / )
			},
		},
	},
	{
		-- <leader>uC: browse & live-preview every installed colorscheme, Enter to apply
		"snacks.nvim",
		keys = {
			{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes (preview)" },
		},
	},
}
