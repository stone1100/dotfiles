--- @class lin.utils.highlights
local highlights = {}

-- override colorschema highlights
function highlights.override(hl, c)
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
    bg = "#2f334d",
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
  hl.CursorLineNr = {
    fg = c.purple,
    -- style = { italic = true },
  }
  hl.CursorLine = {
    bg = "#2f334d",
  }
  hl.CursorColumn = {
    bg = "#2f334d",
  }
  hl.ColorColumn = {
    bg = "#2f334d",
  }
  hl.NeoTreeGitUntracked = {
    fg = c.purple,
    italic = true,
  }
  hl.NeoTreeGitConflict = {
    fg = c.red,
    italic = true,
  }
  hl.NeoTreeGitModified = {
    fg = c.orange,
    italic = true,
  }
  hl.WhichKeySeparator = {
    fg = c.green,
  }
end
return highlights
