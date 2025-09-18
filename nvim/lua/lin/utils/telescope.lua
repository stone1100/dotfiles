---@class lin.utils.telescope
local telescope = {}

function telescope.dropdown()
	local actions = require("telescope.actions")
	return require("telescope.themes").get_dropdown({
		winblend = 15,
		results_title = "",
		selection_caret = "󰼛 ", --" "
		borderchars = {
			{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
			preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		},
		mappings = {
			i = {
				-- Close on first esc instead of going to normal mode
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default, -- open current
				["<C-v>"] = actions.select_horizontal, -- open split horizontal
				["<C-h>"] = actions.select_vertical, -- open split vertical
			},
		},
		layout_config = {
			width = 0.6,
			height = 0.40,
			prompt_position = "top",
		},
		color_devicons = true,
	})
end

return telescope
