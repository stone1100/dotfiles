--- @class lin.utils.highlights
local highlights = {}

-- override colorschema highlights
-- ref: https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
function highlights.override(hl, c)
  local colors = {
    cursor_bg = c.bg_popup,
  }
  if lin.utils.common.is_dark() then
    colors.cursor_bg = "#2f334d"
  end
  local border_fg = c.comment
  hl.TelescopePromptTitle = {
    fg = c.fg,
  }
  hl.TelescopePreviewTitle = {
    fg = c.fg,
  }
  hl.TelescopeResultsTitle = {
    fg = c.fg,
  }
  hl.TelescopeBorder = {
    fg = border_fg,
  }
  hl.TelescopePromptBorder = {
    fg = border_fg,
  }
  hl.TelescopeSelection = {
    bg = colors.cursor_bg,
  }
  hl.TelescopeSelectionCaret = {
    fg = c.green,
  }
  hl.TelescopeMatching = {
    fg = c.purple,
  }
  hl.LspInfoBorder = {
    fg = border_fg,
  }
  hl.CmpPmenuBorder = {
    fg = border_fg,
  }
  hl.CmpBorder = {
    fg = border_fg,
  }
  hl.CmpDocumationBorder = {
    fg = border_fg,
  }
  hl.CmpItemAbbrMatchFuzzy = {
    fg = c.purple,
  }
  hl.CmpItemAbbrMatch = {
    fg = c.purple,
  }
  hl.NeoTreeFloatBorder = {
    fg = border_fg,
  }
  hl.NoiceCmdlinePopupBorder = {
    fg = border_fg,
  }
  hl.NoiceCmdlineIcon = {
    fg = border_fg,
  }
  hl.NoiceCmdlinePopupTitle = {
    fg = c.fg,
  }
  hl.NoiceCmdlineIconSearch = {
    fg = border_fg,
  }
  hl.NoiceCmdlinePopupBorderSearch = {
    fg = border_fg,
  }
  hl.NoiceConfirmBorder = {
    fg = border_fg,
  }
  hl.FloatBorder = {
    fg = border_fg,
  }
  hl.GitSignsAdd = {
    fg = c.green,
  }
  hl.DashboardFooter = {
    fg = c.green,
  }
  hl.DashboardIcon = {
    fg = c.purple,
  }
  hl.DashboardDesc = {
    fg = c.purple,
  }
  hl.CursorLine = {
    bg = colors.cursor_bg,
  }
  hl.CursorColumn = {
    bg = colors.cursor_bg,
  }
  hl.ColorColumn = {
    bg = colors.cursor_bg,
  }
  hl.NeoTreeGitUntracked = {
    fg = c.purple,
    italic = true,
  }
  hl.NeoTreeGitConflict = {
    fg = c.red,
    italic = true,
  }
  hl.NeoTreeModified = {
    fg = c.orange,
  }
  hl.NeoTreeGitModified = {
    fg = c.orange,
    italic = true,
  }
  hl.WhichKeySeparator = {
    fg = c.green,
  }
  hl.WinSeparator = {
    bold = true,
    fg = c.green,
  }
  hl.LineNrAbove = {
    italic = true,
    fg = c.comment,
  }
  hl.LineNrBelow = {
    italic = true,
    fg = c.comment,
  }
  hl.CursorLineNr = {
    bold = true,
    fg = c.green,
    italic = true,
  }
  hl.Cursor = {
    bg = c.green,
  }
end
return highlights
