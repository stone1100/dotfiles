local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local custColors = require("colors")
local condition = require('galaxyline.condition')
local icons = require("icons")
local gls = gl.section
gl.short_line_list = { 'NvimTree', 'vista', 'dbui', 'packer' }

colors.bg = custColors.Bg

local get_lsp_client = function(msg)
	msg = msg or 'No Active Lsp'
	local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end

	local lsps = {}
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			table.insert(lsps, client.name)
		end
	end
	return "[" .. table.concat(lsps, ",") .. "]"
end

gls.left[1] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				[''] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[''] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				['r?'] = colors.cyan,
				['!'] = colors.red,
				t = colors.red
			}
			vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
			return " " .. icons.Vim .. " "
		end,
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.green, colors.gb },
	},
}
gls.left[2] = {
	FileSize = {
		-- provider = 'FileSize',
		provider = function()
			-- show current line percent of all lines
			local current_line = vim.fn.line('.')
			local total_line = vim.fn.line('$')
			return string.format("%d/%d ", current_line, total_line)
		end,
		condition = condition.buffer_not_empty,
		highlight = { colors.fg, colors.bg }
	}
}
gls.left[3] = {
	FileIcon = {
		provider = 'FileIcon',
		condition = condition.buffer_not_empty,
		highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg },
	},
}

gls.left[4] = {
	FileName = {
		provider = 'FileName',
		condition = condition.buffer_not_empty,
		highlight = { colors.magenta, colors.bg }
	}
}

gls.left[5] = {
	LineInfo = {
		provider = function()
			local line = vim.fn.line('.')
			local column = vim.fn.col('.')
			return string.format("%d:%d ", line, column)
		end,
		-- separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.fg, colors.bg },
	},
}

gls.left[6] = {
	PerCent = {
		provider = 'LinePercent',
		-- separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.fg, colors.bg },
	}
}

gls.left[7] = {
	DiagnosticError = {
		provider = 'DiagnosticError',
		icon = icons.Error,
		highlight = { colors.red, colors.bg }
	}
}
gls.left[8] = {
	DiagnosticWarn = {
		provider = 'DiagnosticWarn',
		icon = icons.Warn,
		highlight = { colors.yellow, colors.bg },
	}
}

gls.left[9] = {
	DiagnosticHint = {
		provider = 'DiagnosticHint',
		icon = icons.Hint,
		highlight = { colors.cyan, colors.bg },
	}
}
gls.left[10] = {
	DiagnosticInfo = {
		provider = 'DiagnosticInfo',
		icon = icons.Info,
		highlight = { colors.blue, colors.bg },
	}
}

gls.right[1] = {
	ShowLspClient = {
		provider = get_lsp_client,
		condition = function()
			local tbl = { ['dashboard'] = true, [''] = true }
			if tbl[vim.bo.filetype] then
				return false
			end
			return true
		end,
		icon = icons.Lsp .. 'Lsp:',
		highlight = { custColors.Green, colors.bg }
	}
}

gls.right[2] = {
	FileEncode = {
		provider = 'FileEncode',
		condition = condition.hide_in_width,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.fg, colors.bg }
	}
}

gls.right[3] = {
	FileFormat = {
		provider = function()
			local fformat = vim.bo.fileformat
			local icon = icons.Cry
			if fformat == "unix" then
				icon = icons.Linux
			elseif fformat == "dos" then
				icon = icons.Windows
			elseif fformat == "mac" then
				icon = icons.Mac
			end
			return icon .. ' '
		end,
		-- condition = condition.hide_in_width,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.fg, colors.bg }
	}
}

gls.right[4] = {
	GitIcon = {
		provider = function() return icons.Git .. " " end,
		condition = condition.check_git_workspace,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.violet, colors.bg },
	}
}

gls.right[5] = {
	GitBranch = {
		provider = 'GitBranch',
		condition = condition.check_git_workspace,
		highlight = { colors.violet, colors.bg },
	}
}

gls.right[6] = {
	DiffAdd = {
		provider = 'DiffAdd',
		condition = condition.hide_in_width,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		icon = " " .. icons.Collapse .. " ",
		highlight = { colors.green, colors.bg },
	}
}
gls.right[7] = {
	DiffModified = {
		provider = 'DiffModified',
		condition = condition.hide_in_width,
		icon = " " .. icons.Edit .. " ",
		highlight = { colors.orange, colors.bg },
	}
}
gls.right[8] = {
	DiffRemove = {
		provider = 'DiffRemove',
		condition = condition.hide_in_width,
		icon = " " .. icons.Collapse .. " ",
		highlight = { colors.red, colors.bg },
	}
}

gls.short_line_left[1] = {
	BufferType = {
		provider = 'FileTypeName',
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { custColors.Orange, colors.bg }
	}
}

gls.short_line_left[2] = {
	SFileName = {
		provider = 'SFileName',
		condition = condition.buffer_not_empty,
		highlight = { colors.fg, colors.bg }
	}
}

gls.short_line_right[1] = {
	BufferIcon = {
		provider = 'BufferIcon',
		highlight = { colors.fg, colors.bg }
	}
}
