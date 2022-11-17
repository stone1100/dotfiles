local nvim_lsp = require("lspconfig")
local utils = require("utils")

-- INFO: Don't forget to install typescript language server itself
-- npm i -g typescript-language-server
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
