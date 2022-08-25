require("which-key").register({
	t = {
		name = "Test",
		u = { "<cmd>GoTestFunc<cr>", "Run Test For Current Func" },
		f = { "<cmd>GoTestFile<cr>", "Run Test For Current File" },
		p = { "<cmd>GoTestPkg<cr>", "Run Test For Current Package" },
		c = { "<cmd>GoCoverage<cr>", "Run Coverage" },
	},
	c = {
		name = "Coding",
		o = { "<cmd>GoPkgOutline<cr>", "Go Package Outline" },
		g = { "<cmd>GoGenerate<cr>", "Go Generate" },
		s = { "<cmd>GoAltV<cr>", "Goto Soruce For Test File" },
	}
}, { prefix = "<leader>", { mode = "n" }, { silent = true } })
