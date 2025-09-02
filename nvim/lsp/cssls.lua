local lsp_util = require("lin.utils.lsp")

---@type vim.lsp.Config
return {
	on_attach = function(client, bufnr)
		lsp_util.on_attach(client, bufnr)
		-- disbale formatting, use eslint
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	settings = {
		css = {
			validate = false,
			lint = {
				-- TODO: https://github.com/tailwindlabs/tailwindcss/discussions/5258#discussioncomment-1979394
				unknownAtRules = 'ignore',
			},
		},
		scss = { validate = true },
		less = { validate = true },
	},
	root_dir = lsp_util.get_root_dir("package.json"),
}
