local lazy = require("bufferline.lazy")
local icons = lazy.require("icons")

require("bufferline").setup({
	options = {
		mode = "buffers",
		numbers = "none", -- both
		modified_icon = icons.Modified,
		indicator = {
			icon = icons.Cat,
			style = "icon",
		},
		buffer_close_icon = icons.Close,
		left_trunc_marker = icons.Left,
		right_trunc_marker = icons.Right,
		max_name_length = 14,
		max_prefix_length = 13,
		tab_size = 20,
		show_buffer_close_icons = true,
		show_buffer_icons = true,
		show_tab_indicators = true,
		always_show_bufferline = true,
		separator_style = "thin",
		color_icons = true,
		offsets = {
			{
				filetype = "NvimTree",
				text = icons.FolderTree .. " File Explorer",
				text_align = "left",
				padding = 1,
			},
		},
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diagnostics_dict, _)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and icons.Error or (e == "warning" and icons.Warn or icons.Hint)
				s = s .. sym .. n
			end
			return s
		end,
	},
	highlights = {},
})
