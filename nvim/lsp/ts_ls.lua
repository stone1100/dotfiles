local lsp_util = require("lin.utils.lsp")

-- INFO: Don't forget to install typescript language server itself
-- npm i -g typescript-language-server
-- override language server settings
---@type vim.lsp.Config
return {
	on_attach = function(client, bufnr)
		lsp_util.on_attach(client, bufnr)
		-- disbale formatting, use eslint
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	flags = { debounce_text_changes = 150, exit_timeout = 1000 },
	filetypes = { "typescriptreact", "typescript" },
	root_dir = lsp_util.get_root_dir("package.json"),
}
