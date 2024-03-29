-- set nvim opt
local function set_options()
	local global_local = {
		number = true,
		termguicolors = true,
		relativenumber = true,
		autoindent = true,
		tabstop = 4,
		shiftwidth = 4,
		softtabstop = 0,
		ruler = false,
		cursorline = true,
		cursorcolumn = true,
		undofile = true,
		--		undodir = global.cache_dir .. "undo/",
		timeoutlen = 1000,
		spelllang = "en",
	}

	for name, value in pairs(global_local) do
		vim.o[name] = value
	end
end

set_options()

vim.cmd [[set colorcolumn=140]]
