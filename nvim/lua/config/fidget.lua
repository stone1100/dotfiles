-- https://github.com/j-hui/fidget.nvim
local fidget = require("fidget")
fidget.setup({
	notification = {
		override_vim_notify = true,
		window = {
			normal_hl= "FloatNormal",
			winblend = 15,
		},
	},
	integration = {
		["nvim-tree"] = {
			enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
		},
	},
})
