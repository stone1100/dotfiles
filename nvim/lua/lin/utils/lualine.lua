---@class lin.utils.lualine
local M = {}

function M.cmp_source(name, icon)
  local started = false
  local function status()
    if not package.loaded["cmp"] then
      return
    end
    for _, s in ipairs(require("cmp").core.sources) do
      if s.name == name then
        if s.source:is_available() then
          started = true
        else
          return started and "error" or nil
        end
        if s.status == s.SourceStatus.FETCHING then
          return "pending"
        end
        return "ok"
      end
    end
  end

  local tokyonight_colors = require("tokyonight.colors").setup({ transform = true })
  local colors = {
    ok = tokyonight_colors.green,
    error = tokyonight_colors.red,
    pending = tokyonight_colors.yellow,
  }

  return {
    function()
      return icon or lin.options.icons[name]
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
