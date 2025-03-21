---@class lin.utils
---@field common lin.utils.common
---@field highlights lin.utils.highlights
---@field telescope lin.utils.telescope
---@field lualine lin.utils.lualine
local M = {
  common = require("lin.utils.common"),
  highlights = require("lin.utils.highlights"),
  telescope = require("lin.utils.telescope"),
  lualine = require("lin.utils.lualine"),
}

return M
