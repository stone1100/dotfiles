vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd lspsaga.nvim]])

require("lsp-format").setup({})

local nvim_lsp = require("lspconfig")
local mason_lsp = require("mason-lspconfig")
local utils = require("utils")

-- Override diagnostics symbol
vim.diagnostic.config({
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	virtual_text = {
		source = true,
		prefix = "💀 ", -- " ",
		spacing = 0,
	},
})

-- need setup mason lsp config, here. because lsp config need use
--"java-test",
--"java-debug-adapter",
mason_lsp.setup({
	ensure_installed = {
		"bashls",
		--		"sumneko_lua",
		"tsserver",
		"jdtls",
		-- "stylua",
		"gopls",
		"tailwindcss",
		"cssls",
		"eslint",
		"stylelint_lsp",
		"lemminx",
	},
	automatic_installation = true,
})

for _, name in ipairs(mason_lsp.get_installed_servers()) do
	if name == "gopls" then
		-- go via go.nvim
		goto continue
	end
	local ok, _ = pcall(require, string.format("server.%s", name))
	if not ok then
		nvim_lsp[name].setup({
			on_attach = utils.on_attach,
			capabilities = utils.capabilities
		})
	end
	::continue::
end
