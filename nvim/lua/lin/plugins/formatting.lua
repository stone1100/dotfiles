return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "VeryLazy", "BufReadPre" },
		cmd = { "Conform" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports-reviser", "gofumpt" },
				-- css = { "stylelint_lsp" },
				json = { "deno_fmt" },
				-- typescriptreact = { "eslint" },
				-- typescript = { { "prettierd", "prettier" } },
				-- typescriptreact = { { "prettierd", "prettier" } },
				-- javascript = { { "prettierd", "prettier" } },
				-- javascriptreact = { { "prettierd", "prettier" } },
			},
			log_level = vim.log.levels.ERROR,
			format_after_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 5000,
				async = true,
				lsp_fallback = true,
			},
		},
	},
}
