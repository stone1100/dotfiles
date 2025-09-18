---@class lin.utils.lualine
local M = {}

function M.codeium_status()
	local function status()
		local ok, mod = pcall(require, "codeium")
		if ok then
			if mod.s.healthy then
				return "ok"
			end
		end
		return "error"
	end

	local tokyonight_colors = require("tokyonight.colors").setup({ transform = true })
	local colors = {
		ok = tokyonight_colors.green,
		error = tokyonight_colors.red,
		pending = tokyonight_colors.yellow,
	}
	local key = "codeium"

	return {
		function()
			return lin.options.icons[key]
		end,
		cond = function()
			return status() ~= nil
		end,
		color = function()
			return { fg = colors[status()] or colors.error }
		end,
	}
end

return M
