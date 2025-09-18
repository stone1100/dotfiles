local icons = lin.options.icons
local date_time = function()
	local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
	if thingy == nil then
		return ""
	end
	local date = thingy:read("*a")
	thingy:close()

	local datetime = os.date(icons.time .. " %H:%M")
	return " " .. icons.calendar .. " " .. date .. " " .. datetime
end
return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			-- find
			{ "<leader>ff", "<cmd>lua Snacks.picker.files()<cr>",         desc = "Find files" },
			{ "<leader>fb", "<cmd>lua Snacks.picker.buffers()<cr>",       desc = "Find buffers" },
			{ "<leader>fh", "<cmd>lua Snacks.picker.recent()<cr>",        desc = "Find recent files" },
			{ "<leader>fd", "<cmd>lua Snacks.picker.todo_comments()<cr>", desc = "Find todo lists" },
			{ "<leader>fe", "<cmd>lua Snacks.picker.diagnostics()<cr>",   desc = "Find diagnostics" },
			{
				"<leader>fg",
				"<cmd>lua Snacks.picker.files({exclude = { '%_test.go','%_mock.go' }})<cr>",
				desc = "Find go files",
			},

			-- git
			{ "<leader>gb", "<cmd>lua Snacks.picker.git_branches()<cr>",          desc = "Git Branches" },
			{ "<leader>gl", "<cmd>lua Snacks.picker.git_log()<cr>",               desc = "Git Log" },
			{ "<leader>gs", "<cmd>lua Snacks.picker.git_status()<cr>",            desc = "Git Status" },
			{ "<leader>gd", "<cmd>lua Snacks.picker.git_diff()<cr>",              desc = "Git Diff(Hunks)" },

			-- search
			{ "<leader>sg", "<cmd>lua Snacks.picker.grep()<cr>",                  desc = "Live grep" },
			{ "<leader>sl", "<cmd>lua Snacks.picker.lines()<cr>",                 desc = "Buffer Lines" },
			{ "<leader>sb", "<cmd>lua Snacks.picker.grep_buffers()<cr>",          desc = "Grep Open Buffers" },
			{ "<leader>sw", "<cmd>lua Snacks.picker.grep_word()<cr>",             desc = "Visual selection or word", mode = { "n", "x" } },
			{ "<leader>sC", "<cmd>lua Snacks.picker.commands()<cr>",              desc = "Commands" },
			{ "<leader>sc", "<cmd>lua Snacks.picker.command_history()<cr>",       desc = "Command history" },
			{ "<leader>sd", "<cmd>lua Snacks.picker.diagnostics()<cr>",           desc = "Diagnostics" },
			{ "<leader>sk", "<cmd>lua Snacks.picker.keymaps()<cr>",               desc = "Keymaps" },
			{ "<leader>sh", "<cmd>lua Snacks.picker.help()<cr>",                  desc = "Help" },
			{ "<leader>su", "<cmd>lua Snacks.picker.undo()<cr>",                  desc = "Help" },

			-- lsp
			{ "gr",         "<cmd>lua Snacks.picker.lsp_references()<cr>",        nowait = true,                     desc = "References" },
			{ "gi",         "<cmd>lua Snacks.picker.lsp_implementations()<cr>",   desc = "Goto Implementation" },
			{ "gy",         "<cmd>lua Snacks.picker.lsp_type_definitions()<cr>",  desc = "Goto T[y]pe Definition" },
			{ "gd",         "<cmd>lua Snacks.picker.lsp_definitions()<cr>",       desc = "Goto Definition" },
			{ "gt",         "<cmd>lua Snacks.picker.lsp_declarations()<cr>",      desc = "Goto Declaration" },
			{ "<leader>lw", "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>", desc = "LSP workspace symbols" },
			{ "<leader>ls", "<cmd>lua Snacks.picker.lsp_symbols()<cr>",           desc = "LSP symbols" },

			-- picker
			{ "<leader>pa", "<cmd>lua Snacks.picker()<cr>",                       desc = "All pickers" },
			{ "<leader>pb", function() Snacks.profiler.start() end,               desc = "Profiler start" },
			{ "<leader>pe", function() Snacks.profiler.stop() end,                desc = "Profiler stop" },
		},
		---@module "snacks.nvim"
		---@type snacks.Config
		opts = {
			input = { enabled = true },
			picker = {
				enabled = true,
				sources = {
					lsp_implementations = {
						filter = {
							filter = function(item, _)
								if not item.file then
									return false -- Return false for invalid items
								end
								if item.file:match("_mock%.go$") then
									-- ignore go mock generate file
									return false
								end
								return true
							end,
						},
					},
				},
				layouts = {
					vscode = {
						layout = {
							backdrop = false,
							row = 1,
							width = 0.4,
							min_width = 80,
							height = 0.4,
							border = "none",
							box = "vertical",
							{ win = "input",   height = 1,          border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
							{ win = "list",    border = "single" },
							{ win = "preview", title = "{preview}", border = "rounded" },
						}
					}
				},
			},
			profiler = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = true },
			toggle = { enabled = true },
			win = { enabled = false },
			dashboard = {
				enabled = true,
				sections = {
					{ section = "terminal", cmd = "fortune -s | cowsay", hl = "header", padding = 3, indent = 8 },
					{ section = "keys",     padding = 3,                 gap = 1 },
					{ section = "startup" },
					{
						title = icons.rocket .. " LinVim(" .. lin.version .. ")" .. date_time(),
						align = "center",
						hl = "header",
					},
				},
				preset = {
				},
				formats = {
					key = function(item)
						return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
					end,
				},
			},
			bigfile = { enabled = true },
			explorer = { enabled = true },
			indent = {
				enabled = true,
				scope = {
					enabled = true, -- enable highlighting the current scope
					char = "│",
				},

			},
			styles = {
				dashboard = {
					bo = {
						filetype = "dashboard",
					}
				},
				input = {
					relative = "cursor",
					row = 1,
				}
			}

		},
	}
}
