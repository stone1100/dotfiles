local wezterm = require("wezterm")

---@class Config
---@field options table
local Config = {}

Config.__index = Config

--- Initialize Config
---@return Config
function Config:init()
  local config = setmetatable({ options = {} }, self)
  return config
end

--- Append to Config.options
--- @return Config
function Config:append(new_opts)
  for k, v in pairs(new_opts) do
    if self.options[k] ~= nil then
      wezterm.log_warn("duplicate config option detected: ", { old = self.options[k], new = v })
      goto continue
    end
		self.options[k] = v
    ::continue::
  end
  return self
end

return Config
