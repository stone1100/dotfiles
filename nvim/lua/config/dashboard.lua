local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
if thingy == nil then
	return
end
local date = thingy:read("*a")
thingy:close()

local datetime = os.date(" %H:%M")

local hi_top_section = {
	type = "text",
	val = "┌─────────────   Today is "
		.. date
		.. " ─────────────┐",
	opts = {
		position = "center",
		hl = "EcovimHeaderInfo",
	},
}

local hi_middle_section = {
	type = "text",
	val = "│                                                  │",
	opts = {
		position = "center",
		hl = "EcovimHeaderInfo",
	},
}

local hi_bottom_section = {
	type = "text",
	val = "└─────────────────────  "
		.. datetime
		.. "  ──────────────────┘",
	opts = {
		position = "center",
		hl = "EcovimHeaderInfo",
	},
}

dashboard.section.header.val = {
	[[        /\          /\          /\       ]],
	[[     /\//\\/\    /\//\\/\    /\//\\/\    ]],
	[[  /\//\\\///\\/\//\\\///\\/\//\\\///\\/\ ]],
	[[ //\\\//\/\\///\\\//\/\\///\\\//\/\\///\\]],
	[[ \\//\/                            \/\\//]],
	[[  \/                                  \/ ]],
	[[  /\                                  /\ ]],
	[[ //\\  Neovim IDE with LSP and DAP   //\\]],
	[[ \\//                                \\//]],
	[[  \/                                  \/ ]],
	[[  /\                                  /\ ]],
	[[ //\\/\                            /\//\\]],
	[[ \\///\\/\//\\\///\\/\//\\\///\\/\//\\\//]],
	[[  \/\\///\\\//\/\\///\\\//\/\\///\\\//\/ ]],
	[[      \/\\//\/    \/\\//\/    \/\\//\/   ]],
	[[         \/          \/          \/      ]],
}

local function button(sc, txt, leader_txt, keybind, keybind_opts)
	local sc_after = sc:gsub("%s", ""):gsub(leader_txt, "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 5,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
	}

	if nil == keybind then
		keybind = sc_after
	end
	keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
	opts.keymap = { "n", sc_after, keybind, keybind_opts }

	local function on_press()
		-- local key = vim.api.nvim_replace_termcodes(keybind .. '<Ignore>', true, false, true)
		local key = vim.api.nvim_replace_termcodes(sc_after .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

local leader = "comma"
dashboard.section.buttons.val = {
	--		button("comma s c", " Scheme change", leader, "<cmd>Telescope colorscheme<cr>"),
	button("comma f r", "  File frecency", leader, "<cmd>Telescope frecency<cr>"),
	button("comma f e", "󰄉  Recently used", leader, "<cmd>Telescope oldfiles<cr>"),
	button("comma f p", "  Project find", leader, "<cmd>Telescope project<cr>"),
	button("comma f f", "󰈞  File find", leader, "<cmd>Telescope find_files<cr>"),
	button("comma f n", "󰊄  File new", leader, "<cmd>enew<cr>"),
	button("comma f w", "󰄉  Find text", leader, "<cmd>Telescope live_grep<cr>"),
}
dashboard.section.buttons.opts.hl = "String"

local function footer()
	local total_plugins = #vim.tbl_keys(packer_plugins)
	return "   Have Fun with neovim"
		.. "   v"
		.. vim.version().major
		.. "."
		.. vim.version().minor
		.. "."
		.. vim.version().patch
		.. "    "
		.. total_plugins
		.. " plugins "
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Function"

local head_butt_padding = 2
local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
local header_padding = math.max(0, math.ceil((vim.fn.winheight("$") - occu_height) * 0.25))
local foot_butt_padding = 1

dashboard.config.layout = {
	{ type = "padding", val = header_padding },
	dashboard.section.header,
	{ type = "padding", val = foot_butt_padding },
	hi_top_section,
	hi_middle_section,
	hi_bottom_section,
	{ type = "padding", val = head_butt_padding },
	dashboard.section.buttons,
	{ type = "padding", val = foot_butt_padding },
	dashboard.section.footer,
}

-- set autocmd can show bufferline
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
