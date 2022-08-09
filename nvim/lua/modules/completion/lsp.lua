vim.cmd([[packadd lsp_signature.nvim]])
vim.cmd([[packadd lspsaga.nvim]])
vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd aerial.nvim]])
vim.cmd([[packadd vim-illuminate]])

local nvim_lsp = require("lspconfig")
local saga = require("lspsaga")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local utils = require("modules.completion.utils")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "◍",
		},
	},
})

mason_lsp.setup({
	ensure_installed = {
		"bash-language-server",
		"sumneko_lua",
		--		"gopls", -- use go.nvim
		"typescript-language-server",
		"lua-language-server",
		"stylua",
		"tailwindcss-language-server",
		"css-lsp",
	},
})

-- Override diagnostics symbol
vim.diagnostic.config({
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	virtual_text = {
		source = true,
	},
})

-- sago config
saga.init_lsp_saga({
	error_sign = "",
	warn_sign = "",
	hint_sign = "",
	infor_sign = "",
})

for _, name in ipairs(mason_lsp.get_installed_servers()) do
	local ok, _ = pcall(require, string.format("modules.completion.server.%s", name))
	if not ok then
		nvim_lsp[name].setup({
			on_attach = utils.custom_attach,
			capabilities = utils.capabilities,
		})
	end
end
