local icons = lin.options.icons
local common = lin.utils.common
return {
	{
		"nvim-lualine/lualine.nvim",
		event = { "VeryLazy", "VimEnter" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local colors = lin.utils.common.get_colors()
			local theme = "onelight"
			if lin.utils.common.is_dark() then
				theme = "onedark"
			end

			return {
				options = {
					theme = theme,
					component_separators = "",
					section_separators = "",
					globalstatus = true, -- enable global statusline (have a single statusline
					disabled_filetypes = {
						"dashboard",
						"prompt",
						"TelescopePrompt",
					},
				},
				sections = {
					lualine_a = {
						{
							function()
								local mode = {
									-- c = "🅒",
									-- i = "🅘",
									-- n = "🅝",
									-- r = "🅡",
									-- s = "🅢",
									-- t = "🅣",
									-- v = "🅥",
								}
								local mode_code = vim.api.nvim_get_mode().mode
								if mode[mode_code] == nil then
									return lin.options.mode_icons
								end
								return mode[mode_code]
							end,
							-- color = { fg = tcolors.comment },
							-- color = utils.get_vi_mode_color,
							separator = { right = "" },
						},
					},
					lualine_b = {
						{ "filetype", icon_only = true },
						{
							"filename",
							symbols = {
								modified = icons.modified,
								readonly = icons.readonly,
								unnamed = "[No Name]",
								newfile = icons.new_file,
							},
							separator = { right = "" },
						},
					},
					lualine_c = {
						{ "branch", icon = icons.git },
						{
							"diff",
							symbols = {
								added = icons.collapse .. " ",
								modified = icons.edit .. " ",
								removed = icons.expand .. " ",
							},
							source = function()
								-- local gitsigns = vim.b.gitsigns_status_dict
								-- if gitsigns then
								-- 	return {
								-- 		added = gitsigns.added,
								-- 		modified = gitsigns.changed,
								-- 		removed = gitsigns.removed,
								-- 	}
								-- end
								local summary = vim.b.minidiff_summary
								return summary
										and {
											added = summary.add,
											modified = summary.change,
											removed = summary.delete,
										}
							end,
						},
						-- {
						--
						-- 	function()
						-- 		return require("nvim-treesitter").statusline({
						-- 			indicator_size = 70,
						-- 			type_patterns = { "class", "function", "method" },
						-- 			separator = " -> ",
						-- 		})
						-- 	end,
						-- },
					},
					lualine_x = {
						-- Snacks.profiler.status(),
						lin.utils.lualine.codeium_status(),
						{
							common.get_lsp_clients,
							icon = icons.lsp,
							color = { fg = colors.purple },
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = icons.error, warn = icons.warn, info = icons.info },
						},
					},
					lualine_y = {
						{
							"fileformat",
							icons_enabled = true,
							separator = { left = "" },
						},
						{ "encoding", separator = { right = "" } },
					},
					lualine_z = {
						{ "searchcount", color = { gui = "" } },
						-- { "location", color = { gui = "" } },
						{
							function()
								local line = vim.fn.line(".")
								local col = vim.fn.virtcol(".")
								return string.format("%d:%d", line, col)
							end,
							color = { gui = "" },
						},
						{ "progress",    color = { gui = "" } },
					},
				},
			}
		end,
	},
}
