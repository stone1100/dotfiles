local utils = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
utils.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

function utils.on_attach(client, bufnr)
	require("lsp-format").on_attach(client)

	-- enable navic for displaying current context
	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
end

return utils
