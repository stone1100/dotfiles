local colors = require("utils.colors")
local umath = require("utils.math")
local wezterm = require("wezterm")

local nf = wezterm.nerdfonts
local M = {}

local discharging_icons = {
  nf.md_battery_10,
  nf.md_battery_20,
  nf.md_battery_30,
  nf.md_battery_40,
  nf.md_battery_50,
  nf.md_battery_60,
  nf.md_battery_70,
  nf.md_battery_80,
  nf.md_battery_90,
  nf.md_battery,
}
local charging_icons = {
  nf.md_battery_charging_10,
  nf.md_battery_charging_20,
  nf.md_battery_charging_30,
  nf.md_battery_charging_40,
  nf.md_battery_charging_50,
  nf.md_battery_charging_60,
  nf.md_battery_charging_70,
  nf.md_battery_charging_80,
  nf.md_battery_charging_90,
  nf.md_battery_charging,
}
-- wezterm FormatItems (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)
local __cells__ = {}

---@param text string
---@param icon string
---@param fg string
local push = function(text, icon, fg)
  table.insert(__cells__, { Foreground = { Color = fg } })
  table.insert(__cells__, { Attribute = { Intensity = "Half" } })
  table.insert(__cells__, { Text = icon .. text })
end

local set_date = function()
  local date = wezterm.strftime(" %a %H:%M:%S")
  push(date, "", colors.foreground)
end

-- ref: https://wezfurlong.org/wezterm/config/lua/wezterm/battery_info.html
local set_battery = function()
  local charge = 0
  local icon = ""

  for _, b in ipairs(wezterm.battery_info()) do
    local idx = umath.clamp(umath.round(b.state_of_charge * 10), 1, 10)
    charge = b.state_of_charge

    if b.state == "Charging" then
      icon = charging_icons[idx]
    else
      icon = discharging_icons[idx]
    end
  end
  local fg = colors.green
  if charge < 0.05 then
    fg = colors.red1
  elseif charge < 0.35 then
    fg = colors.yellow
  end

  push(string.format("%.0f%%", charge * 100), icon .. " ", fg)
end

M.setup = function()
  wezterm.on("update-right-status", function(window, _)
    __cells__ = {}
    set_battery()
    set_date()
    window:set_right_status(wezterm.format(__cells__))
  end)
end

return M
