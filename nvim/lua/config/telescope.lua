local telescope = require("telescope")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local fb_actions = require("telescope").extensions.file_browser.actions
local icons = require("icons")

telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true,          -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case" or "smart_case"
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		file_browser = {
			mappings = {
				i = {
					["<c-n>"] = fb_actions.create,
					["<c-r>"] = fb_actions.rename,
					-- ["<c-h>"] = actions.which_key,
					["<c-h>"] = fb_actions.toggle_hidden,
					["<c-x>"] = fb_actions.remove,
					["<c-p>"] = fb_actions.move,
					["<c-y>"] = fb_actions.copy,
					["<c-a>"] = fb_actions.select_all,
				},
			},
		},
		frecency = {
			auto_validate = false,
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		buffers = {
			ignore_current_buffer = true,
			sort_lastused = true,
		},
		-- find_command = { "fd", "--hidden", "--type", "file", "--follow", "--strip-cwd-prefix" },
	},
	defaults = {
		path_display = {
			shorten = {
				len = 1, exclude = { 1, -1 }
			},
			truncate = true
		},
		dynamic_preview_title = true,
		-- if ignore .git, builtin lsp will not work
		-- https://github.com/nvim-telescope/telescope.nvim/issues/1924
		file_ignore_patterns = { "node_modules", ".terraform", "%.jpg", "%.png", "%.git", "*.class" },
		-- used for grep_string and live_grep
		vimgrep_arguments = {
			"rg",
			"--follow",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--no-ignore",
			"--trim",
		},
		mappings = {
			i = {
				-- Close on first esc instead of going to normal mode
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<C-q>"] = actions.send_selected_to_qflist,
				["<C-l>"] = actions.send_to_qflist + actions.open_qflist,
				-- ["<C-l>"] =require("trouble.sources.telescope").open,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<cr>"] = actions.select_default,
				["<c-v>"] = actions.select_vertical,
				["<c-s>"] = actions.select_horizontal,
				["<c-t>"] = actions.select_tab,
				["<c-p>"] = action_layout.toggle_preview,
				["<c-o>"] = action_layout.toggle_mirror,
				["<c-h>"] = actions.which_key,
				["<c-x>"] = actions.delete_buffer,
			},
		},
		prompt_prefix = " " .. icons.Term .. " ",
		selection_caret = icons.Point .. " ",
		entry_prefix = "  ",
		multi_icon = "",
		initial_mode = "insert",
		scroll_strategy = "cycle",
		selection_strategy = "reset",
		results_title = false,
		--sorting_strategy = "descending",
		sorting_strategy = "ascending",
		-- layout_strategy = "horizontal",
		layout_strategy = "vertical",
		layout_config = {
			width = 0.95,
			height = 0.90,
			-- preview_cutoff = 120,
			prompt_position = "top",
			horizontal = {
				preview_width = function(_, cols, _)
					if cols > 200 then
						return math.floor(cols * 0.4)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},
			vertical = { width = 0.8, height = 0.8, preview_height = 0.5 },
			flex = { horizontal = { preview_width = 0.8 } },
		},
		winblend = 0,
		border = {},
		--borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
	},
})

telescope.load_extension("project")
telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("packer")
telescope.load_extension("ui-select")
telescope.load_extension("frecency")

-- show all commands include builtin and extensions
local function list_all_telescope_commands()
	local commands = {}
	-- builtin commands
	for name, _ in pairs(require 'telescope.builtin') do
		table.insert(commands, 'Telescope ' .. name)
	end
	-- extensions, such as 'telescope-packer.nvim'
	local extensions = require 'telescope'.extensions
	for _, ext_table in pairs(extensions) do
		for func_name, _ in pairs(ext_table) do
			table.insert(commands, 'Telescope ' .. func_name)
		end
	end
	return commands
end
local function show_telescope_commands()
	local pickers = require 'telescope.pickers'
	local finders = require 'telescope.finders'
	local conf = require 'telescope.config'.values
	local action_state = require 'telescope.actions.state'
	--	local actions = require 'telescope.actions'

	pickers.new({}, {
		prompt_title = 'Telescope Commands',
		finder = finders.new_table {
			results = list_all_telescope_commands(),
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry,
					ordinal = entry,
				}
			end,
		},
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, _)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd(selection.value)
			end)
			return true
		end,
	}):find()
end

vim.api.nvim_create_user_command('TelescopeCommands', show_telescope_commands, {})
