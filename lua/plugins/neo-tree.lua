-- Neo-tree's `<leader>e` clobbers vscode.lua's VSCode-command mapping for the
-- same key (it's a real floating/sidebar nvim window VSCode can't render).
-- Disabled entirely inside VSCode; use the real Explorer instead.
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
				-- Root line normally shows the full "~/"-relative cwd (eg.
				-- "~/gaian-refactor/gaian-user-service"). Collapse it to just
				-- "~/<project-name>" so deeply nested repos don't push the
				-- tree header off the sidebar width.
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

		-- Neo-tree italicizes untracked/conflicted git files and the root
		-- folder name by default, and colors folder icons a generic light
		-- blue. Force upright text + recolor folders to match VSCode's
		-- material-icon-theme.folders.color (#90a4ae). Re-applied on every
		-- colorscheme change since neo-tree resets its own highlights there
		-- too (see neo-tree/setup/init.lua VIM_COLORSCHEME handler).
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
