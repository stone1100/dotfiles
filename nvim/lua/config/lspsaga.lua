local saga = require("lspsaga")
local icons = require("icons")

saga.setup({
	ui = {
		imp_sign = icons.Down,
		expand = icons.Expand,
		collapse = icons.Collapse,
	},
	lightbulb = {
		sign = false,
	},
	outline = {
		layout = "normal",
	},
	implement = {
		enable = true,
	},
	floaterm = {
		height = 0.9,
		width = 0.9,
	},
	code_action = {
		show_server_name = true,
		extend_gitsigns = false,
	},
	diagnostic = {
		show_code_action = true,
	},
})
