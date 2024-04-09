local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = { 'NvimTree', 'vista', 'dbui', 'packer' }

colors.bg = "#3d3d3d"

-- gls.left[1] = {
-- 	RainbowRed = {
-- 		provider = function() return '▊ ' end,
-- 		highlight = { colors.blue, colors.bg }
-- 	},
-- }
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
			return '  '
		end,
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
		icon = '  ',
		highlight = { colors.red, colors.bg }
	}
}
gls.left[8] = {
	DiagnosticWarn = {
		provider = 'DiagnosticWarn',
		icon = '  ',
		highlight = { colors.yellow, colors.bg },
	}
}

gls.left[9] = {
	DiagnosticHint = {
		provider = 'DiagnosticHint',
		icon = '  ',
		highlight = { colors.cyan, colors.bg },
	}
}

gls.left[10] = {
	DiagnosticInfo = {
		provider = 'DiagnosticInfo',
		icon = '  ',
		highlight = { colors.blue, colors.bg },
	}
}

gls.right[1] = {
	ShowLspClient = {
		provider = 'GetLspClient',
		condition = function()
			local tbl = { ['dashboard'] = true, [''] = true }
			if tbl[vim.bo.filetype] then
				return false
			end
			return true
		end,
		icon = ' LSP:',
		highlight = { colors.green, colors.bg }
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
			local icon = '󰱭'
			if fformat == "unix" then
				icon = ''
			elseif fformat == "dos" then
				icon = ''
			elseif fformat == "mac" then
				icon = ''
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
		provider = function() return ' ' end,
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
		icon = '  ',
		highlight = { colors.green, colors.bg },
	}
}
gls.right[7] = {
	DiffModified = {
		provider = 'DiffModified',
		condition = condition.hide_in_width,
		icon = ' 󰤌 ',
		highlight = { colors.orange, colors.bg },
	}
}
gls.right[8] = {
	DiffRemove = {
		provider = 'DiffRemove',
		condition = condition.hide_in_width,
		icon = '  ',
		highlight = { colors.red, colors.bg },
	}
}

-- gls.right[9] = {
-- 	RainbowBlue = {
-- 		provider = function() return ' ▊' end,
-- 		highlight = { colors.blue, colors.bg }
-- 	},
-- }

gls.short_line_left[1] = {
	BufferType = {
		provider = 'FileTypeName',
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.blue, colors.bg }
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
