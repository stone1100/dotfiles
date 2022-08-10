local tools = {}
local conf = require("modules.tools.config")

tools["nvim-lua/plenary.nvim"] = { opt = false }
tools["nvim-telescope/telescope.nvim"] = {
	--opt = true,
	module = "telescope",
	cmd = "Telescope",
	config = conf.telescope,
	requires = {
		{ "nvim-lua/plenary.nvim", opt = false },
		{ "nvim-lua/popup.nvim", opt = true },
		"telescope-ui-select.nvim", "telescope-fzf-native.nvim",
	},
}
tools["nvim-telescope/telescope-fzf-native.nvim"] = {
	opt = true,
	run = "make",
	after = "telescope.nvim",
}
tools["nvim-telescope/telescope-project.nvim"] = {
	opt = true,
	after = "telescope-fzf-native.nvim",
}
tools["nvim-telescope/telescope-frecency.nvim"] = {
	opt = true,
	after = "telescope-project.nvim",
	requires = { { "tami5/sqlite.lua", opt = true } },
}
tools["nvim-telescope/telescope-file-browser.nvim"] = {
	opt = true,
	after = "telescope-project.nvim",
}
tools["nvim-telescope/telescope-ui-select.nvim"] = {
	opt = true,
	after = "telescope.nvim",
}
tools["dstein64/vim-startuptime"] = { opt = true, cmd = "StartupTime" }
tools["folke/which-key.nvim"] = {
	opt = true,
	keys = ",",
	config = conf.which_key,
}

return tools
