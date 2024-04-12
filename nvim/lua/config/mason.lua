local icons = require("icons")
require("mason").setup({
	ui = {
		icons = {
			package_installed = icons.Todo,
			package_pending = icons.Pending,
			package_uninstalled = icons.Mason,
		},
	},
})
