local completion = {}
local conf = require("modules.completion.config")

-- lsp config
completion["neovim/nvim-lspconfig"] = {
	opt = true,
	event = "BufReadPre",
	config = conf.nvim_lsp,
}
completion["SmiteshP/nvim-navic"] = {
	opt = true,
	after = "nvim-lspconfig",
	config = conf.navic,
}
completion["lukas-reineke/lsp-format.nvim"] = {
	opt = true,
	after = "nvim-lspconfig",
}
-- lsp install
completion["williamboman/mason.nvim"] = {
	requires = {
		{
			"williamboman/mason-lspconfig.nvim",
		},
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", config = conf.mason_install },
	},
}
completion["kevinhwang91/nvim-bqf"] = {
	opt = true,
	ft = "qf",
	config = conf.bqf,
}
completion["tami5/lspsaga.nvim"] = {
	opt = true,
	after = "nvim-lspconfig",
}
-- outline
completion["stevearc/aerial.nvim"] = {
	opt = true,
	after = "nvim-lspconfig",
	config = conf.aerial,
}
completion["kosayoda/nvim-lightbulb"] = {
	opt = true,
	after = "nvim-lspconfig",
	config = conf.lightbulb,
}
-- show function signature
completion["ray-x/lsp_signature.nvim"] = { opt = true, after = "nvim-lspconfig" }
-- comde completion
completion["hrsh7th/nvim-cmp"] = {
	config = conf.cmp,
	event = "InsertEnter",
	requires = {
		{ "lukas-reineke/cmp-under-comparator" },
		{ "hrsh7th/cmp-nvim-lsp", after = "LuaSnip" },
		{ "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
		{ "f3fora/cmp-spell", after = "cmp-path" },
		{ "hrsh7th/cmp-buffer", after = "cmp-spell" },
	},
}
-- snippet engine
completion["L3MON4D3/LuaSnip"] = {
	after = "nvim-cmp",
	config = conf.luasnip,
	requires = "rafamadriz/friendly-snippets",
}

-- auto pairs
completion["windwp/nvim-autopairs"] = {
	after = "nvim-cmp",
	config = conf.autopairs,
}

return completion
