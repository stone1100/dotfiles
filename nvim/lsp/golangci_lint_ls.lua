---@type vim.lsp.Config
return {
	on_attach = function(client, _)
		if client.server_capabilities.textDocumentSync ~= nil then
			client.server_capabilities.textDocumentSync.change = 0
		end
	end,
}
