local colors = require("utils.colors")
local icons = require("utils.icons")
local wezterm = require("wezterm")
local nf = wezterm.nerdfonts

local M = {}

local __cells__ = {}

local process_icon = function(process_name)
  local icon = icons.process[process_name]
  if icon ~= nil then
    table.insert(__cells__, { Text = wezterm.format(icon) })
  else
    local text = process_name
    icon = nf["md_" .. text]
    if icon ~= nil then
      text = icon
    end
    table.insert(
      __cells__,
      { Text = wezterm.format({
        { Foreground = { Color = colors.blue } },
        { Text = text },
      }) }
    )
  end
  table.insert(__cells__, { Text = " " })
end

local theme_colors = {
  default = { bg = colors.dark5, fg = colors.foreground },
  is_active = { bg = colors.dark5, fg = colors.purple },
  hover = { bg = colors.dark5, fg = colors.purple },
}

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local basename = function(s)
  local a = string.gsub(s, "(.*[/\\])(.*)", "%2")
  return a:gsub("%.exe$", "")
end

local get_attributes = function(tab)
  local attributes = {}
  table.insert(attributes, { Intensity = "Half" })
  if tab.is_active then
    table.insert(attributes, { Italic = true })
  end
  return attributes
end

---@param fg string
---@param bg string
---@param attributes table
---@param text string
local push = function(bg, fg, attributes, text)
  table.insert(__cells__, { Background = { Color = bg } })
  table.insert(__cells__, { Foreground = { Color = fg } })
  for _, a in ipairs(attributes) do
    table.insert(__cells__, { Attribute = a })
  end
  table.insert(__cells__, { Text = text })
end

M.setup = function()
  wezterm.on("format-tab-title", function(tab, _, _, _, hover, _)
    __cells__ = {}

    local bg
    local fg
    local process_name = basename(tab.active_pane.foreground_process_name)

    if tab.is_active then
      bg = theme_colors.is_active.bg
      fg = theme_colors.is_active.fg
    elseif hover then
      bg = theme_colors.hover.bg
      fg = theme_colors.hover.fg
    else
      bg = colors.background
      fg = colors.foreground
    end

    if tab.tab_index == 0 then
      push(colors.background, colors.foreground, {}, " 󰢚  ")
    end

    -- if tab.tab_index ~= 0 then
    --   push(bg, colors.comment, {}, "|")
    -- end

    local attrs = get_attributes(tab)
    push(bg, colors.green, attrs, icons.nubmer[tab.tab_index + 1])
    process_icon(process_name)
    push(bg, fg, attrs, basename(tab.active_pane.title))
    push(bg, fg, {}, " ")
    return __cells__
  end)
end

return M
