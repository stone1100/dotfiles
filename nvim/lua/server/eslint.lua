local nvim_lsp = require("lspconfig")
local utils = require("utils")
local function on_attach(client, bufnr)
	-- client.server_capabilities.document_formatting = true
	-- client.server_capabilities.document_range_formatting = true
	utils.on_attach(client, bufnr)
	-- autocmd BufWritePre * sleep 200m
	vim.cmd([[
    augroup Format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> EslintFixAll
    augroup END
    ]])
	require("which-key").register({
		c = {
			name = "Coding",
			f = { "<cmd>EslintFixAll<cr>", "Format" },
		},
		f = {
			name = "Files",
			s = { "<cmd>EslintFixAll<cr><cmd>w<cr>", "Save Buffer" },
		},
	}, { prefix = "<leader>", { mode = "n" }, { silent = true } })

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
