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
					-- "hard" = bg0_h #1d2021, khớp chính xác theme "Gruvbox Dark Hard"
					-- (jdinhlife.gruvbox) đang dùng trong VSCode — cùng bảng màu gốc.
					contrast = "hard",
					-- Nền đục #1d2021 giống hệt editor.background của VSCode (không
					-- trong suốt nữa). Nếu WezTerm đang set window_background_opacity
					-- < 1.0, nền terminal vẫn có thể lộ qua tuỳ compositing của terminal.
					transparent_mode = false,
				})
				vim.o.background = "dark"
				vim.cmd.colorscheme("gruvbox")

				-- gruvbox.nvim colors ALL functions (both definitions and calls)
				-- the same green used for strings, and generic operators orange.
				-- VSCode's "Gruvbox Dark Hard" (jdinhlife.gruvbox) instead uses:
				-- function/method definitions = yellow #fabd2f, function/method
				-- calls = aqua #8ec07c, plain operators = aqua #8ec07c. Align
				-- these so code doesn't "read" differently between the two.
				local function align_with_vscode_gruvbox()
					vim.api.nvim_set_hl(0, "Function", { fg = "#fabd2f" })
					vim.api.nvim_set_hl(0, "@function.call", { fg = "#8ec07c" })
					vim.api.nvim_set_hl(0, "@operator", { fg = "#8ec07c" })

					-- gruvbox.nvim tints all brackets/commas/dots orange (Delimiter
					-- group) and colors bare variable references the same as plain
					-- text. VSCode's Gruvbox Dark Hard keeps punctuation muted and
					-- colors most bare identifiers blue via a broad "variable.other"
					-- rule - true for (nearly) every language, not just Go.
					vim.api.nvim_set_hl(0, "Delimiter", { fg = "#a89984" })
					vim.api.nvim_set_hl(0, "@variable", { fg = "#83a598" })

					-- Go-specific: verified against the real go.tmLanguage.json grammar
					-- + Gruvbox Dark Hard theme by tokenizing an actual file with
					-- vscode-textmate (not guessed). Go's grammar uses ONE scope
					-- ("entity.name.function.support.go") for every function/method
					-- CALL - same purple as declarations, no aqua/yellow distinction
					-- like the generic (non-Go) rule other languages fall back to.
					-- "@capture.go" only applies inside Go buffers (Neovim resolves
					-- language-suffixed highlight groups before the generic one).
					vim.api.nvim_set_hl(0, "@function.go", { fg = "#d3869b" })
					vim.api.nvim_set_hl(0, "@function.call.go", { fg = "#d3869b" })
					vim.api.nvim_set_hl(0, "@function.method.go", { fg = "#d3869b" })
					vim.api.nvim_set_hl(0, "@function.method.call.go", { fg = "#d3869b" })
					-- Treesitter specially flags "New*"/"make*" calls as @constructor
					-- (orange via "Special"); VSCode's Go grammar has no such concept,
					-- these are colored the same purple as any other call.
					vim.api.nvim_set_hl(0, "@constructor.go", { fg = "#d3869b" })
					-- Type names get plain foreground in Go (no yellow "pop"), both at
					-- use-sites (@type.go, already set above) and at declaration sites
					-- ("type Foo struct{}" -> @type.definition, a separate capture).
					vim.api.nvim_set_hl(0, "@type.go", { fg = "#ebdbb2" })
					vim.api.nvim_set_hl(0, "@type.definition.go", { fg = "#ebdbb2" })
					-- Const declaration names are blue (variable.other.constant.go),
					-- not purple like gruvbox.nvim's generic Constant/GruvboxPurple.
					vim.api.nvim_set_hl(0, "@constant.go", { fg = "#83a598" })
					-- `nil`/`iota` are purple (constant.language.null.go), not orange
					-- (gruvbox.nvim links @constant.builtin to the orange "Special").
					vim.api.nvim_set_hl(0, "@constant.builtin.go", { fg = "#d3869b" })
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

-- <leader>uC opens a floating Snacks picker that can't render inside VSCode
-- (vscode.lua's <leader>uc there calls VSCode's own theme picker instead).
if not vim.g.vscode then
	table.insert(specs, {
		-- <leader>uC: browse & live-preview every installed colorscheme, Enter to apply
		"snacks.nvim",
		keys = {
			{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes (preview)" },
		},
	})
end

return specs
