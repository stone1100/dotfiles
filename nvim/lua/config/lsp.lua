local config = {}

-- lsp config
function config.lsp()
	vim.cmd([[packadd cmp-nvim-lsp]])

	local nvim_lsp = require("lspconfig")
	local mason_lsp = require("mason-lspconfig")
	local utils = require("utils")
	-- need setup mason lsp config, here. because lsp config need use
	mason_lsp.setup({
		ensure_installed = {
			"bash-language-server",
			"sumneko_lua",
			"typescript-language-server",
			"stylua",
			"tailwindcss-language-server",
		},
	})

	for _, name in ipairs(mason_lsp.get_installed_servers()) do
		if name == "golsp" then
			-- go via go.nvim
			return
		end
		local ok, _ = pcall(require, string.format("server.%s", name))
		if not ok then
			nvim_lsp[name].setup({
				on_attach = utils.on_attach,
				capabilities = utils.capabilities,
			})
		end
	end
			nvim_lsp["sumneko_lua"].setup({
				on_attach = utils.on_attach,
				capabilities = utils.capabilities,
			})
end

function config.navic()
	require("nvim-navic").setup({
		highlight = false,
	})
end

function config.lsp_format()
	--require("lsp-format").setup({
		--go = {
		--   order = { "gopls", "efm" }
		-- },
	--	lua = {
--		order = { "sumneko_lua" }
--}
--	})
end

return config
