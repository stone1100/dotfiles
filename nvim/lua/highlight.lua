vim.cmd([[colorscheme tokyonight]])

vim.cmd[[hi NormalFloat guibg=none]]
-- https://github.com/folke/tokyonight.nvim/pull/137#issuecomment-1016239546
-- improved telescope background
vim.cmd[[hi TelescopeNormal guibg=none]]
vim.cmd[[hi TelescopeBorder guibg=none]]
vim.cmd[[hi TelescopePromptTitle guifg=orange]]
vim.cmd[[hi TelescopePreviewTitle guifg=orange]]

-- cmp
vim.cmd[[hi LspFloatWinNormal guibg=none]]
vim.cmd[[hi BufferLineIndicatorSelected guifg=orange]]
vim.cmd[[hi Comment guifg=gray]]
vim.api.nvim_set_hl(0,"CmpBorder",{default =true,link="TelescopeBorder"})
vim.api.nvim_set_hl(0,"CmpBorder",{default =true,link="TelescopeBorder"})
vim.cmd[[hi Pmenu guibg=none]]

-- which key
vim.cmd[[hi WhichKeyFloat guibg=none]]
vim.cmd[[hi WhichKey guifg=orange]]
-- normal
vim.cmd[[hi FloatBorder guibg=none]]
