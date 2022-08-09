local lang = {}
local conf = require("modules.lang.config")

lang["ray-x/go.nvim"] = {
	opt = true,
	ft = "go",
	run = ":GoInstallBinaries",
	config = conf.go,
}

return lang
