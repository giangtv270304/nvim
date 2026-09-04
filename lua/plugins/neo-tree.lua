-- Can't render in VSCode; vscode.lua's <leader>e opens the real Explorer instead.
if vim.g.vscode then
	return {}
end

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
					["l"] = "open", -- l: open file / expand folder
					["h"] = "close_node", -- h: collapse folder
					["<space>"] = "none", -- disable Space toggle so it doesn't shadow the leader key
				},
			},
			filesystem = {
				hijack_netrw_behavior = "open_default", -- open as a left sidebar
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				-- Collapse the root line to "~/<project-name>" so deeply nested
				-- repos don't push the header off the sidebar width.
				components = {
					name = function(config, node, state)
						local common = require("neo-tree.sources.common.components")
						if node:get_depth() == 1 and node.type ~= "message" then
							local original_name = node.name
							node.name = "~/" .. vim.fn.fnamemodify(node.path, ":t")
							local result = common.name(config, node, state)
							node.name = original_name
							return result
						end
						return common.name(config, node, state)
					end,
				},
			},
		})

		-- Un-italicize git status text and match folder icon to Material Icon
		-- Theme; re-applied on ColorScheme since neo-tree resets these itself.
		local function apply_material_style()
			vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { italic = false })
			vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { italic = false, bold = true })
			vim.api.nvim_set_hl(0, "NeoTreeRootName", { italic = false, bold = true })
			vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#90a4ae" })
		end
		apply_material_style()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_material_style })
	end,
}
