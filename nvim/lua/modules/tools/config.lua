local config = {}

function config.telescope()
	vim.cmd([[packadd sqlite.lua]])
	vim.cmd([[packadd telescope-fzf-native.nvim]])
	vim.cmd([[packadd telescope-project.nvim]])
	vim.cmd([[packadd telescope-frecency.nvim]])
	vim.cmd([[packadd telescope-file-browser.nvim]])
	vim.cmd([[packadd telescope-ui-select.nvim]])
	--	vim.cmd([[packadd telescope-zoxide]])

	local telescope_actions = require("telescope.actions.set")
	local fixfolds = {
		hidden = true,
		attach_mappings = function(_)
			telescope_actions.select:enhance({
				post = function()
					vim.cmd(":normal! zx")
				end,
			})
			return true
		end,
	}

	require('telescope').load_extension("fzf")
	require('telescope').load_extension("project")
	--	require("telescope").load_extension("zoxide")
	require('telescope').load_extension("frecency")
	require('telescope').load_extension("file_browser")
	require('telescope').load_extension("ui-select")

	require('telescope').setup({
		defaults = {
			initial_mode = "insert",
			numbers = "both",
			prompt_prefix = "  ",
			selection_caret = " ",
			entry_prefix = " ",
			scroll_strategy = "limit",
			results_title = false,
			layout_strategy = "horizontal",
			sorting_strategy = "ascending",
			shorten_path = true,
			path_display = { "shorten" },
			file_ignore_patterns = {},
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.8,
				height = 0.80,
				preview_cutoff = 120,
			},
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			frecency = {
				show_scores = true,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/tmp/*" },
			},
			file_browser = {
				--	theme = "ivy",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				mappings = {
					["i"] = {
						-- your custom insert mode mappings
					},
					["n"] = {
						-- your custom normal mode mappings
					},
				},
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
		pickers = {
			buffers = fixfolds,
			find_files = fixfolds,
			git_files = fixfolds,
			grep_string = fixfolds,
			live_grep = fixfolds,
			oldfiles = fixfolds,
		},
	})
end

function config.which_key()
	require("modules.tools.whichkey")
end

function config.key_menu()
	vim.o.timeoutlen = 300
	require("key-menu").set("n", "<Space>")
	require("key-menu").set("n", "g")
end

return config
