local specs = {
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
					contrast = "hard", -- bg0_h #1d2021, matches VSCode's "Gruvbox Dark Hard"
					transparent_mode = false, -- opaque bg, same as VSCode
				})
				vim.o.background = "dark"
				vim.cmd.colorscheme("gruvbox")

				-- Recolor to match VSCode's "Gruvbox Dark Hard" (jdinhlife.gruvbox);
				-- gruvbox.nvim's own defaults diverge per-token (verified by
				-- tokenizing real files with vscode-textmate, not guessed).
				local function align_with_vscode_gruvbox()
					vim.api.nvim_set_hl(0, "Function", { fg = "#fabd2f" })
					vim.api.nvim_set_hl(0, "@function.call", { fg = "#8ec07c" })
					vim.api.nvim_set_hl(0, "@operator", { fg = "#8ec07c" })
					vim.api.nvim_set_hl(0, "Delimiter", { fg = "#a89984" })
					vim.api.nvim_set_hl(0, "@variable", { fg = "#83a598" })

					-- Go-specific ("@capture.go" only applies in Go buffers): Go's
					-- grammar uses one purple scope for every function/method
					-- definition AND call, unlike the generic yellow/aqua split
					-- other languages fall back to.
					vim.api.nvim_set_hl(0, "@function.go", { fg = "#d3869b" })
					vim.api.nvim_set_hl(0, "@function.call.go", { fg = "#d3869b" })
					vim.api.nvim_set_hl(0, "@function.method.go", { fg = "#d3869b" })
					vim.api.nvim_set_hl(0, "@function.method.call.go", { fg = "#d3869b" })
					vim.api.nvim_set_hl(0, "@constructor.go", { fg = "#d3869b" })
					vim.api.nvim_set_hl(0, "@type.go", { fg = "#ebdbb2" })
					vim.api.nvim_set_hl(0, "@type.definition.go", { fg = "#ebdbb2" })
					vim.api.nvim_set_hl(0, "@constant.go", { fg = "#83a598" })
					vim.api.nvim_set_hl(0, "@constant.builtin.go", { fg = "#d3869b" }) -- nil/iota
				end
				align_with_vscode_gruvbox()
				vim.api.nvim_create_autocmd("ColorScheme", {
					group = vim.api.nvim_create_augroup("VscodeGruvboxAlign", { clear = true }),
					callback = align_with_vscode_gruvbox,
				})
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
}

-- Floating picker can't render inside VSCode; vscode.lua's <leader>uc uses VSCode's theme picker instead.
if not vim.g.vscode then
	table.insert(specs, {
		"snacks.nvim",
		keys = {
			{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes (preview)" },
		},
	})
end

return specs
