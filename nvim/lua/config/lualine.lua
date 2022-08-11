local navic = require("nvim-navic")
local function navic_content()
	if navic.is_available() then
		return navic.get_location()
	else
		return ""
	end
end

local function escape_status() local ok, m = pcall(require, "better_escape")
	return ok and m.waiting and "✺ " or ""
end

-- Lsp server name .
local function lsp_client_name()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	local client_names = {}
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			client_names[client.name] = true
		end
	end
	if next(client_names) then
		local names = ""
		for k, _ in pairs(client_names) do
			if names == "" then
				names = k
			else
				names = names .. "," .. k
			end
		end
		return names
	end
	return msg
end

local function lsp()
	return string.format("[%s]", lsp_client_name())
end

local mini_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = { "location" },
}
local simple_sections = {
	lualine_a = { "mode" },
	lualine_b = { "filetype" },
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = { "location" },
}
local aerial = {
	sections = mini_sections,
	filetypes = { "aerial" },
}
local dapui_scopes = {
	sections = simple_sections,
	filetypes = { "dapui_scopes" },
}

local dapui_breakpoints = {
	sections = simple_sections,
	filetypes = { "dapui_breakpoints" },
}

local dapui_stacks = {
	sections = simple_sections,
	filetypes = { "dapui_stacks" },
}

local dapui_watches = {
	sections = simple_sections,
	filetypes = { "dapui_watches" },
}
local colors = {
	bg = "#202328",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}
local icons = require("icons")
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		disabled_filetypes = {},
		component_separators = "|",
		section_separators = { left = "", right = "" },
		refresh = {
			winbar = 300,
		},
	},
	sections = {
		lualine_a = {
			{ "mode" },
		},

		lualine_b = {
			{ "branch" },
			{
				"diff",
				color = { bg = "#1f2335"},
				-- Is it me or the symbol for modified us really weird
				symbols = { added = " ", modified = "柳", removed = " " },
				color_added = colors.green,
				color_modified = colors.orange,
				color_removed = colors.red,
				condition = conditions.hide_in_width,
			},
		},
		lualine_c = { { navic_content, cond = navic.is_available, color = { fg = colors.violet } } },
		lualine_x = {
			{ escape_status },
			{
				lsp,
				icon = " LSP:",
				color = { fg = colors.violet, gui = "bold" },
			},
			{
				"lsp_progress",
				--					display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
				-- With spinner
				display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
				colors = {
					percentage = colors.cyan,
					title = colors.cyan,
					message = colors.cyan,
					spinner = colors.cyan,
					lsp_client_name = colors.magenta,
					use = true,
				},
				separators = {
					component = " ",
					progress = " | ",
					---@diagnostic disable-next-line: duplicate-index
					message = { pre = "(", post = ")" },
					percentage = { pre = "", post = "%% " },
					title = { pre = "", post = ": " },
					lsp_client_name = { pre = "[", post = "]" },
					spinner = { pre = "", post = "" },
					---@diagnostic disable-next-line: duplicate-index
					message = { commenced = "In Progress", completed = "Completed" },
				},
				timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
				spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
			},
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = icons.error, warn = icons.warn, info = icons.info },
			},
		},
		lualine_y = {
			{ "filetype", colored = true, icon_only = true },
			{ "encoding" },
			{
				"fileformat",
				icons_enabled = true,
				symbols = {
					unix = "LF",
					dos = "CRLF",
					mac = "CR",
				},
			},
		},
		lualine_z = {
			"progress",
			"location",
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	extensions = {
		"quickfix",
		"nvim-tree",
		"toggleterm",
		"fugitive",
		aerial,
		dapui_scopes,
		dapui_breakpoints,
		dapui_stacks,
		dapui_watches,
	},
})
