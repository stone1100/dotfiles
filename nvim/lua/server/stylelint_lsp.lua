local nvim_lsp = require("lspconfig")
local utils = require("utils")

-- override language server settings
nvim_lsp.stylelint_lsp.setup({
	on_attach = utils.on_attach,
	filetypes = { "css", "scss", "less" },
	settings = {
		stylelintplus = {
			autoFixOnSave = true,
			autoFixOnFormat = true,
			enable = true,
		}
	},
})
