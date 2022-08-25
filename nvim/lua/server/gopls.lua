local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")
local utils = require("utils")

-- override language server settings
nvim_lsp.gopls.setup({
	on_attach = utils.on_attach,
	flags = { debounce_text_changes = 150 },
	capabilities = utils.capabilities,
	cmd = { "gopls", "-remote=auto" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			usePlaceholders = true,
			analyses = {
				nilness = true,
				shadow = true,
				unusedparams = true,
				unusewrites = true,
			},
		},
	},
})
