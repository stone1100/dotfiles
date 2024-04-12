local icons = require("icons")
local colors = require("colors")
local devicons = require("nvim-web-devicons")
devicons.set_icon {
	["go.mod"] = {
		icon = icons.Go,
		color = colors.Go,
		cterm_color = "74",
		name = "Go",
	},
	["go.sum"] = {
		icon = icons.Go,
		color = colors.Go,
		cterm_color = "74",
		name = "Go",
	},
}
devicons.refresh()
