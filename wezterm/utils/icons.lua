local colors = require("utils.colors")

-- https://github.com/nvim-tree/nvim-web-devicons/blob/master/lua/nvim-web-devicons/icons-default.lua
local icons = {
  process = {
    ["make"] = {
      { Foreground = { Color = colors.purple } },
      { Text = " " },
    },
    ["docker"] = {
      { Foreground = { Color = colors.blue } },
      { Text = "󰡨 " },
    },
    ["docker-compose"] = {
      { Foreground = { Color = colors.blue } },
      { Text = "󰡨 " },
    },
    ["nvim"] = {
      { Foreground = { Color = colors.blue } },
      { Text = "" },
    },
    ["bob"] = {
      { Foreground = { Color = colors.blue } },
      { Text = "" },
    },
    ["vim"] = {
      { Foreground = { Color = colors.blue } },
      { Text = " " },
    },
    ["node"] = {
      { Foreground = { Color = colors.green } },
      { Text = " " },
    },
    ["zsh"] = {
      { Foreground = { Color = colors.peach } },
      { Text = " " },
    },
    ["bash"] = {
      { Foreground = { Color = colors.overlay1 } },
      { Text = " " },
    },
    ["htop"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = " " },
    },
    ["btop"] = {
      { Foreground = { Color = colors.rosewater } },
      { Text = " " },
    },
    ["cargo"] = {
      { Foreground = { Color = colors.peach } },
      { Text = " " },
    },
    ["go"] = {
      { Foreground = { Color = colors.sapphire } },
      { Text = " " },
    },
    ["git"] = {
      { Foreground = { Color = colors.peach } },
      { Text = " " },
    },
    ["lazygit"] = {
      { Foreground = { Color = colors.mauve } },
      { Text = "󰊢 " },
    },
    ["lua"] = {
      { Foreground = { Color = colors.blue } },
      { Text = " " },
    },
    ["wget"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = "󰄠 " },
    },
    ["curl"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = " " },
    },
    ["gh"] = {
      { Foreground = { Color = colors.mauve } },
      { Text = " " },
    },
    ["flatpak"] = {
      { Foreground = { Color = colors.blue } },
      { Text = "󰏖 " },
    },
    ["dotnet"] = {
      { Foreground = { Color = colors.mauve } },
      { Text = "󰪮 " },
    },
    ["paru"] = {
      { Foreground = { Color = colors.mauve } },
      { Text = "󰣇" },
    },
    ["yay"] = {
      { Foreground = { Color = colors.mauve } },
      { Text = "󰣇" },
    },
    ["fish"] = {
      { Foreground = { Color = colors.green } },
      { Text = "󰈺 " },
    },
  },
  nubmer = {
    "¹",
    "²",
    "³",
    "⁴",
    "⁵",
    "⁶",
    "⁷",
    "⁸",
    "⁹",
    "¹⁰",
    "¹¹",
    "¹²",
    "¹³",
    "¹⁴",
    "¹⁵",
    "¹⁶",
    "¹⁷",
    "¹⁸",
    "¹⁹",
    "²⁰",
  },
}

return icons
