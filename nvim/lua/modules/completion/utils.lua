local utils = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
utils.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

function utils.custom_attach(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true,
		use_lspsaga = false,
		floating_window = true,
		fix_pos = true,
		hint_enable = true,
		hi_parameter = "Search",
		handler_opts = { "double" },
	})
	require("aerial").on_attach(client)
	require("illuminate").on_attach(client)
	require("lsp-format").on_attach(client)
	-- neable navic for displaying current context
	if client.server_capabilities.documentSymbolProvider then
		local navic = require("nvim-navic")
		navic.attach(client, bufnr)
	end
end

return utils
