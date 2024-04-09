local saga = require("lspsaga")

saga.setup({
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
})
