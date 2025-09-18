return {
	{
		"sontungexpt/url-open",
		event = "BufReadPre",
		cmd = "URLOpenUnderCursor",
		keys = {
			{
				"<leader>ob",
				"<cmd>URLOpenUnderCursor<cr>",
				desc = "URL Open",
			},
		},
		opts = {
			-- https://github.com/sontungexpt/url-open
			open_only_when_cursor_on_url = true,
		},
	},
	{
		"ggandor/leap.nvim",
		config = function()
			local leap = require("leap")
			leap.opts.case_sensitive = true
			leap.opts.highlight_unlabeled = true
			require("leap").create_default_mappings()
		end,
	},
}
