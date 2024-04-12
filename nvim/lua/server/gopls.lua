local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")
local utils = require("utils")

-- override language server settings
nvim_lsp.gopls.setup({
	-- on_attach = utils.on_attach,
	on_attach = function(client, bufnr)
		vim.lsp.codelens.refresh()
		utils.on_attach(client, bufnr)
		-- add go keymapping
		-- require("which-key").register({
		-- 	-- t = {
		-- 	-- 	name = "Test",
		-- 	-- 	-- d = { "<cmd>GoDebug -n<cr>", "Debug Test" },
		-- 	-- 	-- u = { "<cmd>GoTestFunc<cr>", "Run Test For Current Func" },
		-- 	-- 	-- f = { "<cmd>GoTestFile<cr>", "Run Test For Current File" },
		-- 	-- 	p = { "<cmd>GoTestPkg<cr>", "Run Test For Current Package" },
		-- 	-- 	c = { "<cmd>GoCoverage<cr>", "Run Coverage" },
		-- 	-- 	r = { "<cmd>GoCoverage -t<cr>", "Toggle Coverage" },
		-- 	-- },
		-- 	c = {
		-- 		name = "Coding",
		-- 		-- o = { "<cmd>Vista!!<cr>", "Go File Outline" },
		-- 		s = { "<cmd>GoAltV<cr>", "Goto Soruce For Test File" },
		-- 	},
		-- 	g = {
		-- 		name = "Golang",
		-- 		m = { "<cmd>GoCmt<cr>", "Add Go Comments" },
		-- 		g = { "<cmd>GoGenerate<cr>", "Go Generate" },
		-- 		p = { "<cmd>GoFixPlurals<cr>", "Fix Plurals" },
		-- 		i = { "<cmd>GoIfErr<cr>", "Add if err" },
		-- 		f = { "<cmd>GoFillStruct<cr>", "Fill struct" },
		-- 		s = { "<cmd>GoFillSwitch<cr>", "Fill switch" },
		-- 	}
		-- }, { prefix = "<leader>", { mode = "n" }, { silent = true } })
		--
		-- -- config hightlight
		-- vim.cmd [[syn match goGenerateVariables contained /\%(\$GOARCH\|\$GOOS\|\$GOFILE\|\$GOLINE\|\$GOPACKAGE\|\$DOLLAR\)\>/]]
		-- vim.cmd [[syn region goGenerate start="^\s*//go:generate" end="$" contains=goGenerateVariables]]
		-- vim.cmd [[hi goGenerate guifg=green gui=bold]]
		--
		-- vim.cmd [[syn match goBuildKeyword contained "+build\|go:build"]]
		-- vim.cmd [[syn region goBuild start="^\s*//\(\s*+build\s\|go:build\)" end="$" contains=goBuildKeyword]]
		-- vim.cmd [[hi goBuild guifg=green gui=bold]]
		-- vim.cmd [[hi goBuildKeyword guifg=green gui=bold]]
		-- vim.cmd [[hi TSComment guifg=gray]]
	end, -- nil: use on_attach function defined in go/lsp.lua,
	flags = { debounce_text_changes = 150 },
	capabilities = utils.capabilities,
	cmd = { "gopls", "-remote=auto" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			usePlaceholders = true,
			analyses = {
				nilness = true,
				shadow = true,
				unusedparams = true,
				unusewrites = true,
			},
		},
	},
})
