local dict = {
	["*"] = { "/usr/share/dict/words" },
	ft = {
		foo = { vim.fn.expand("~/.config/_asserts/dict/words_alpha.txt") },
	},
}
require("cmp_dictionary").setup({
	exact_length = 2,
	max_number_items = 5000,
	first_case_insensitive = true,
	--	document = false,
	--	document_command = "wn %s -over",
	-- capacity = 5,
	debug = false,
	-- paths = {
	-- 	-- vim.fn.expand("~/.config/_asserts/dict/words_alpha.txt"), -- "/usr/share/dict/words"
	-- 	-- vim.fn.expand("~/.config/_asserts/dict"), -- "/usr/share/dict/words"
	-- 	["*"] = vim.fn.expand("~/.config/_asserts/dict/words_alpha.txt"), -- "/usr/share/dict/words"
	-- },
	paths = dict["*"],
	document = {
		enable = true,
		-- https://github.com/uga-rosa/cmp-dictionary/issues/68
		-- command = { "wn", "${label}", "-over" },
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
-- dict.switcher({
-- 	spelllang = {
-- 		en = vim.fn.expand("~/.config/_asserts/dict/words_alpha.txt"), -- "/usr/share/dict/words"
-- 	},
-- })
--			dict.update() -- THIS
