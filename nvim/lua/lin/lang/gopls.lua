local lsp_util = require("lin.utils.lsp")
local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

-- override language server settings
nvim_lsp.gopls.setup({
  on_attach = lsp_util.on_attach,
  -- on_attach = function(client, bufnr)
  --   vim.lsp.codelens.refresh()
  -- lsp_util.on_attach(client, bufnr)
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
  -- end, -- nil: use on_attach function defined in go/lsp.lua,
  flags = { debounce_text_changes = 150 },
  capabilities = lsp_util.capabilities,
  cmd = { "gopls", "-remote=auto" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    -- ref: https://github.com/golang/tools/blob/master/gopls/doc/vim.md
    gopls = {
      usePlaceholders = true,
      staticcheck = true,
      gofumpt = true,
      analyses = {
        -- fieldalignment = true, //removed by gopls v0.17.0
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusewrites = true,
      },
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})
