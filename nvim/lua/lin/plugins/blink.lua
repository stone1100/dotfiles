return {
	-- add blink.compat
	{
		'saghen/blink.compat',
		-- use v2.* for blink.cmp v1.*
		version = '2.*',
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		'saghen/blink.cmp',
		dependencies = {
			'saghen/blink.compat',
			'rafamadriz/friendly-snippets',
			"Exafunction/codeium.nvim",
		},
		version = '1.*',
		event = "InsertEnter",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			completion = {
				-- list = {
				-- 	selection = { preselect = false, auto_insert = false }
				-- },
				accept = {
					-- experimental auto-brackets support
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					border = "single",
					draw = {
						treesitter = { "lsp" },
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "single" },
				},
			},

			keymap = {
				preset = 'default',
				["<CR>"] = { "accept", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				['<C-l>'] = { 'snippet_forward', 'fallback' },
				['<C-h>'] = { 'snippet_backward', 'fallback' },
			},
			sources = {
				default = { 'lsp', 'codeium', 'path', 'snippets', 'buffer' },
				providers = {
					codeium = {
						name = "codeium",
						module = 'codeium.blink',
						-- kind = "Codeium", -- for icon kind
						score_offset = -3,
						async = true,
					},
				}
			},
			signature = {
				enabled = false,
				window = { border = "single" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
			cmdline = {
				sources = { 'buffer', 'cmdline' },
				keymap = { preset = 'inherit' },
				completion = {
					menu = { auto_show = true },
					list = {
						selection = { preselect = false, auto_insert = true }
					},
				},
			},
			-- opts_extend = { "sources.default" }
		}
	}
}
