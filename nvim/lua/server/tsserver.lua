local nvim_lsp = require("lspconfig")
local utils = require("utils")

-- override language server settings
nvim_lsp.tsserver.setup({
	on_attach = utils.on_attach,
	flags = { debounce_text_changes = 150 },
	capabilities = utils.capabilities,
	settings = {
		tsserver = {
			format = { enable = false },
		},
	},
})
