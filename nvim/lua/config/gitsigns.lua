require("gitsigns").setup {
	signs = {
		add = {
			hl = "GitSignsAdd",
			text = "+",
			numhl = "GitSignsAddNr",
			linehl = "GitSignsAddLn"
		},
		change = {
			hl = "GitSignsChange",
			text = "~",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn"
		},
		delete = {
			hl = "GitSignsDelete",
			text = "_",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn"
		},
		topdelete = {
			hl = "GitSignsDelete",
			text = "‾",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn"
		},
		changedelete = {
			hl = "GitSignsChange",
			text = "~",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn"
		}
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = { interval = 1000, follow_files = true },
	attach_to_untracked = true,
	-- git-blame provides also the time in contrast to gitsigns
	current_line_blame = true,
	current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
	sign_priority = 3,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1
	},
	diff_opts = { internal = true },
	yadm = { enable = false }
}
