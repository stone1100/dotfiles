local icons = require("icons")
-- https://github.com/nvim-neotest/neotest
require("neotest").setup({
	adapters = {
		require("neotest-go")({
			experimental = {
				test_table = true,
			},
			args = { "-count=1", "-timeout=120s", "-race", "-coverprofile=coverage.out" }
		}),
	},
--	strategies = { "dap" },
	icons = {
		unknown = icons.HeadQuestion,
		collapsed = icons.Collapse,
		expanded = icons.Expand,
		passed = icons.Todo,
		running = icons.RunLast,
		failed = icons.Close,
		-- https://www.compart.com/en/unicode/block/U+2500
		final_child_prefix = "└",
	},

	log_level = vim.log.levels.DEBUG,
})
