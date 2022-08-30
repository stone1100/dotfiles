local wk = require("which-key")
local silent_opt = { silent = true }
local mode_n = { mode = "n" }

wk.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 2, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = {
		"<silent>",
		"<cmd>",
		"<Cmd>",
		"<cr>",
		"<CR>",
		"call",
		"lua",
		"require",
		"^:",
		"^ ",
	}, -- hide mapping boilerplate
	show_help = false, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
})

wk.register({
	K = { "<cmd>Lspsaga hover_doc<cr>", "Show Doc" },
	e = {
		name = "Diagnostic",
		h = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Jump Previous Diagnostic" },
		l = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Jump Next Diagnostic" },
	},
	g = {
		name = "Goto",
		lf = { "<cmd>Lspsaga lsp_finder<cr>", "LSP Finder" },
		d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
		i = { "<cmd>Telescope lsp_implementations<cr>", "Goto Definition" },
	},
}, { mode_n, silent_opt })

-- mapping leader
wk.register({
	c = {
		name = "Coding",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		f = { "<cmd>lua vim.lsp.buf.format({timeout_ms=1000})<cr>", "Format" },
		h = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "Show References" },
		r = { "<cmd>Lspsaga rename<cr>", "Rename" },
		d = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
		i = { "<cmd>Lspsaga implement<cr>", "Preview Implement" },
	},
	f = {
		name = "Files",
		b = { "<cmd>Telescope file_browser<cr>", "File Browser" },
		e = { "<cmd>Telescope diagnostics<cr>", "Diagnostics File Browser" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		h = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		t = { "<cmd>NvimTreeToggle<cr>", "Toggle Filetree" },
		s = { "<cmd>w<cr>", "Save Buffer" },
	},
	w = {
		name = "Window",
		n = { "<cmd>new<cr>", "New Window" },
		c = { "<cmd>quit<cr>", "Close Window" },
		o = { "<C-W>o", "Close Other Windows" },
		s = { "<cmd>split<cr>", "Split Window" },
		v = { "<cmd>vsplit<cr>", "Split Window(Vertically)" },
		h = { "<C-W>h", "Goto Left Window" },
		l = { "<C-W>l", "Goto Right Window" },
		k = { "<C-W>k", "Goto Top Window" },
		j = { "<C-W>j", "Goto Bottom Window" },
		H = { "<C-W>H", "Move To Left Window" },
		L = { "<C-W>L", "Move To Right Window" },
		K = { "<C-W>K", "Move To Top Window" },
		J = { "<C-W>J", "Move To Bottom Window" },
	},
	b = {
		name = "Buffers",
		l = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer(Cycle)" },
		h = { "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer(Cycle)" },
		p = { "<cmd>BufferLinePick<cr>", "Pick Buffer" },
		f = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
		c = { "<cmd>q<cr>", "Close Buffer" }
	},
}, { prefix = "<leader>", mode_n, silent_opt })
