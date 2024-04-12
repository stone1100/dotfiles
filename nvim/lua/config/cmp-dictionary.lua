local t = ""
local dict = {
	["*"] = { "/usr/share/dict/words" },
	ft = {
		foo = { vim.fn.expand("~/.config/_asserts/dict/words_alpha.txt") },
	},
}
require("cmp_dictionary").setup({
	exact_length = 2,
	max_number_items = 10,
	first_case_insensitive = true,
	debug = false,
	paths = dict["*"],
	document = {
		enable = true,
		command = { "w3m", "https://dict.cn/search?q=${label}" }
	},
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(ev)
		local paths = dict.ft[ev.match] or {}
		vim.list_extend(paths, dict["*"])
		require("cmp_dictionary").setup({
			paths = paths,
		})
	end
})
