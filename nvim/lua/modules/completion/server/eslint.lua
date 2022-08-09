local nvim_lsp = require("lspconfig")
local utils = require("modules.completion.utils")
local function on_attach(client, bufnr)
	-- client.server_capabilities.document_formatting = true
	-- client.server_capabilities.document_range_formatting = true
	utils.custom_attach(client, bufnr)
	vim.cmd([[
    augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre * sleep 200m
        autocmd BufWritePre <buffer> EslintFixAll
    augroup END
    ]])

end

-- override language server settings
nvim_lsp.eslint.setup({
	on_attach = on_attach,
	flags = { debounce_text_changes = 150 },
	capabilities = utils.capabilities,
	settings = {
		eslint = {
			enable = true,
			format = { enable = true },
			autoFixOnSave = true,
			codeActionOnSave = {
				enable = true,
				mode = "all"
			},
			lintTask = {
				enable = true,
			},
		}
	},
})
