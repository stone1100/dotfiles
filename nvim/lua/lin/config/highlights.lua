-- load the colorscheme here
vim.cmd([[colorscheme tokyonight-storm]])
-- selection
-- vim.cmd([[hi Visual guibg=#2e3c64 guifg=#c0caf5 gui=reverse]])

local colors = require("tokyonight.colors").setup({ transform = true })
-- vim.api.nvim_set_hl(0, "BufferLineCloseButton", { bg = colors.bg })
-- vim.api.nvim_set_hl(0, "BufferLineDevIconLua", { bg = colors.bg })
-- vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = colors.purple })
-- vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = colors.purple })
vim.cmd("hi LineNr guifg=" .. colors.comment)
vim.cmd("hi Cursor guibg=" .. colors.green)
vim.cmd("hi CmpItemKindVariable guifg=" .. colors.purple)
-- vim.cmd("hi WinSeparator guifg=#93bb64" .. colors.purple)
-- vim.cmd("hi BufferLineDevIconLua guibg=" .. colors.bg)
