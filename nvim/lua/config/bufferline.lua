require("bufferline").setup({
	options = {
		mode = "buffers",
		numbers = "none", -- both
		modified_icon = "✥",
		-- indicator_icon = '  ',
		indicator = {
			icon = '  ',
			style = "icon",
		},
		buffer_close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
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
				text = " File Explorer",
				text_align = "left",
				padding = 1,
			},
		},
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diagnostics_dict, _)
			local s = " "
			local icons = require("icons")
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and icons.error or (e == "warning" and icons.warn or icons.hint)
				s = s .. sym .. n
			end
			return s
		end,
	},
	highlights = {},
})
