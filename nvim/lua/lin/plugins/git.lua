return {
	{ "tpope/vim-fugitive", event = "BufReadPre", cmd = { "Git", "G" } },
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle git deleted" },
		},
		enabled = false,
		config = function()
			require("gitsigns").setup({
				signs = {
					add = {
						-- hl = "GitSignsAdd",
						text = "+",
						-- numhl = "GitSignsAddNr",
						-- linehl = "GitSignsAddLn",
					},
					change = {
						-- hl = "GitSignsChange",
						text = "~",
						-- numhl = "GitSignsChangeNr",
						-- linehl = "GitSignsChangeLn",
					},
					delete = {
						-- hl = "GitSignsDelete",
						text = "_",
						-- numhl = "GitSignsDeleteNr",
						-- linehl = "GitSignsDeleteLn",
					},
					topdelete = {
						-- hl = "GitSignsDelete",
						text = "‾",
						-- numhl = "GitSignsDeleteNr",
						-- linehl = "GitSignsDeleteLn",
					},
					changedelete = {
						-- hl = "GitSignsChange",
						text = "~",
						-- numhl = "GitSignsChangeNr",
						-- linehl = "GitSignsChangeLn",
					},
					untracked = { text = "▎" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = { interval = 1000, follow_files = true },
				attach_to_untracked = true,
				-- git-blame provides also the time in contrast to gitsigns
				current_line_blame = false,
				current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
				sign_priority = 6,
				update_debounce = 1000,
				status_formatter = nil, -- Use default
				max_file_length = 40000,
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				diff_opts = { internal = true },
				-- yadm = { enable = false },
			})
		end,
	},
}
