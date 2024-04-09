-- NOTE: all LSP and formatting related options are disabeld.
-- NOTE: LSP is handled by lsp.lua and formatting is handled by null-ls.lua

require("go").setup({
	go = "go",             -- go command, can be go[default] or go1.18beta1
	goimports = "gopls",   -- goimport command, can be gopls[default] or goimport
	fillstruct = "gopls",  -- can be nil (use fillstruct, slower) and gopls
	gofmt = "golines",     -- gofmt cmd,
	max_line_len = 120,    -- max line length in golines format
	tag_transform = false, -- tag_transfer  check gomodifytags for details
	test_template = "",    -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
	test_template_dir = "", -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
	comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ       
	--icons = { breakpoint = "🧘", currentpos = "🏃" },
	icons = false,
	verbose = true, -- output loginf in messages
	lsp_inlay_hints = { enable = false },
	lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
	-- false: do nothing
	-- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
	--   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
	-- lsp_cfg = {
	--  	capabilities=capabilities,
	-- },
	lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
	lsp_on_attach = function(client, bufnr)
		vim.lsp.codelens.refresh()
		require("utils").on_attach(client, bufnr)
		-- add go keymapping
		require("which-key").register({
			t = {
				name = "Test",
				d = { "<cmd>GoDebug -n<cr>", "Debug Test" },
				u = { "<cmd>GoTestFunc<cr>", "Run Test For Current Func" },
				f = { "<cmd>GoTestFile<cr>", "Run Test For Current File" },
				p = { "<cmd>GoTestPkg<cr>", "Run Test For Current Package" },
				c = { "<cmd>GoCoverage<cr>", "Run Coverage" },
				r = { "<cmd>GoCoverage -t<cr>", "Toggle Coverage" },
			},
			c = {
				name = "Coding",
				-- o = { "<cmd>Vista!!<cr>", "Go File Outline" },
				s = { "<cmd>GoAltV<cr>", "Goto Soruce For Test File" },
			},
			g = {
				name = "Golang",
				m = { "<cmd>GoCmt<cr>", "Add Go Comments" },
				g = { "<cmd>GoGenerate<cr>", "Go Generate" },
				p = { "<cmd>GoFixPlurals<cr>", "Fix Plurals" },
				i = { "<cmd>GoIfErr<cr>", "Add if err" },
				f = { "<cmd>GoFillStruct<cr>", "Fill struct" },
				s = { "<cmd>GoFillSwitch<cr>", "Fill switch" },
			}
		}, { prefix = "<leader>", { mode = "n" }, { silent = true } })

		-- config hightlight
		vim.cmd [[syn match goGenerateVariables contained /\%(\$GOARCH\|\$GOOS\|\$GOFILE\|\$GOLINE\|\$GOPACKAGE\|\$DOLLAR\)\>/]]
		vim.cmd [[syn region goGenerate start="^\s*//go:generate" end="$" contains=goGenerateVariables]]
		vim.cmd [[hi goGenerate guifg=green gui=bold]]

		vim.cmd [[syn match goBuildKeyword contained "+build\|go:build"]]
		vim.cmd [[syn region goBuild start="^\s*//\(\s*+build\s\|go:build\)" end="$" contains=goBuildKeyword]]
		vim.cmd [[hi goBuild guifg=green gui=bold]]
		vim.cmd [[hi goBuildKeyword guifg=green gui=bold]]
		vim.cmd [[hi TSComment guifg=gray]]
	end, -- nil: use on_attach function defined in go/lsp.lua,
	--      when lsp_cfg is true
	-- if lsp_on_attach is a function: use this function as on_attach function for gopls
	lsp_codelens = true, -- set to false to disable codelens, true by default
	lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
	--lsp_diag_hdlr = true, -- hook lsp diag handler
	diagnostic = {    -- set diagnostic to false to disable diagnostic
		hdlr = true,  -- hook diagnostic handler
		underline = true,
		-- virtual text setup
		virtual_text = { space = 0, prefix = '💀 ' },
		signs = true,
	},
	-- lsp_diag_virtual_text = { space = 0, prefix = "💀 " }, -- virtual text setup ""
	-- lsp_diag_signs = true,
	lsp_diag_update_in_insert = true,
	lsp_document_formatting = false,
	-- set to true: use gopls to format
	-- false if you want to use other formatter tool(e.g. efm, nulls)
	gopls_cmd = nil,       -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
	gopls_remote_auto = true, -- add -remote=auto to gopls
	gocoverage_sign = "█",
	sign_priority = 7,
	dap_debug = true,      -- set to false to disable dap
	dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
	-- false: do not use keymap in go/dap.lua.  you must define your own.
	dap_debug_gui = true,  -- set to true to enable dap gui, highly recommended
	dap_debug_vt = true,   -- set to true to enable dap virtual text
	build_tags = "",       -- set default build tags
	textobjects = true,    -- enable default text obects through treesittter-text-objects
	test_runner = "go",    -- richgo, go test, richgo, dlv, ginkgo
	run_in_floaterm = true, -- set to true to run in float window.
	-- float term recommended if you use richgo/ginkgo with terminal color
})
