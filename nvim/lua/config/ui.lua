local config = {}

function config.theme()
end

function config.nvim_tree()
	require("nvim-tree").setup({
		view = {
			hide_root_folder = false,
		},
		filters = {
			dotfiles = true,
		},
	})
end

function config.cursorline()
	require("nvim-cursorline").setup({
		cursorline = {
			enable = true,
			timeout = 100,
			number = false,
		},
		cursorword = {
			enable = true,
			min_length = 3,
			hl = { underline = true },
		},
	})
end

return config
