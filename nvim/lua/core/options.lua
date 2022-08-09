local global = require("core.global")

local function load_options()
	local global_local = {
		number = true,
		termguicolors = true,
		relativenumber = true,
		autoindent = true,
		tabstop = 4,
		shiftwidth = 4,
		softtabstop = 4,
		ruler = false,

		cursorline = true,
		cursorcolumn = true,

		undofile = true,
		undodir = global.cache_dir .. "undo/",
	}

	for name, value in pairs(global_local) do
		vim.o[name] = value
	end
end

load_options()
