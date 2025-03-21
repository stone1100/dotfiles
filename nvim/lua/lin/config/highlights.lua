-- load the colorscheme here
if lin.utils.common.is_dark() then
  vim.cmd([[colorscheme tokyonight-storm]])
else
  vim.cmd([[colorscheme tokyonight-day]])
end
-- selection
-- vim.cmd([[hi Visual guibg=#2e3c64 guifg=#c0caf5 gui=reverse]])

local colors = require("tokyonight.colors").setup({ transform = true })
-- vim.cmd("hi LineNr guifg=" .. colors.green)
-- vim.cmd("hi Cursor guibg=" .. colors.green)
vim.cmd("hi CmpItemKindVariable guifg=" .. colors.purple)
vim.cmd("hi CmpItemKindSnippet guifg=" .. colors.green)
vim.cmd("hi CmpItemMenu guifg=" .. colors.blue)
vim.cmd("hi GitSignsChange guifg=" .. colors.orange)
vim.cmd("hi GitSignsChangeLn guifg=" .. colors.orange)
vim.cmd("hi GitSignsChangeNr guifg=" .. colors.orange)
vim.cmd("hi GitSignsDelete guifg=" .. colors.red1)
vim.cmd("hi GitSignsDeleteLn guifg=" .. colors.red1)
vim.cmd("hi GitSignsDeleteNr guifg=" .. colors.red1)
-- vim.cmd("hi WinSeparator guifg=" .. colors.green)
