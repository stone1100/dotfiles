local global = require("core.global")

local vim = vim

-- https://alpha2phi.medium.com/

-- Create cache dir and subs dir
local create_dir = function()
	local data_dir = {
		global.cache_dir .. "backup",
		global.cache_dir .. "session",
		global.cache_dir .. "swap",
		global.cache_dir .. "tags",
		global.cache_dir .. "undo",
	}
	-- There only check once that If cache_dir exists
	-- Then I don't want to check subs dir exists
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		os.execute("mkdir -p " .. global.cache_dir)
		for _, v in pairs(data_dir) do
			if vim.fn.isdirectory(v) == 0 then
				os.execute("mkdir -p " .. v)
			end
		end
	end
end

local disable_distribution_plugins = function()
	vim.g.loaded_python3_provider = 0
	vim.g.loaded_ruby_provider = 0
	vim.g.loaded_perl_provider = 0
end

-- set leader key
local leader_map = function()
	vim.g.mapleader = ","
end

local load_core = function()
	local pack = require("core.pack")
	create_dir()
	disable_distribution_plugins()

	require("core.options")
	leader_map()

	pack.ensure_plugins()
	require("core.event")
	require("keymap")
	pack.load_compile()

	vim.cmd([[colorscheme catppuccin]])

	-- load telescope
	vim.cmd([[PackerLoad telescope.nvim]])
end

load_core()
