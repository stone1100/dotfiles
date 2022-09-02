vim.cmd([[colorscheme onedark]])

vim.cmd [[hi NormalFloat guibg=none]]
-- https://github.com/folke/tokyonight.nvim/pull/137#issuecomment-1016239546
-- improved telescope background
vim.cmd [[hi TelescopeNormal guibg=none]]
vim.cmd [[hi TelescopeBorder guibg=none]]
vim.cmd [[hi TelescopeResultsBorder guifg='#5c6370']]
vim.cmd [[hi TelescopePreviewBorder guifg='#5c6370']]
vim.cmd [[hi TelescopePromptBorder guifg='#5c6370']]
vim.cmd [[hi LspSagaDiagnosticBorder guifg='#5c6370']]
vim.cmd [[hi LspSagaHoverBorder guifg='#5c6370']]
vim.cmd [[hi LspSagaDocTruncateLine guifg='#5c6370']]
vim.cmd [[hi LspSagaRenameBorder guifg='#5c6370']]
vim.cmd [[hi TelescopePromptTitle guifg=orange]]
vim.cmd [[hi TelescopePreviewTitle guifg=orange]]

-- cmp
vim.cmd [[hi LspFloatWinNormal guibg=none]]
vim.cmd [[hi Comment guifg=gray]]
vim.api.nvim_set_hl(0, "CmpBorder", { default = true, link = "TelescopeBorder" })
vim.cmd [[hi Pmenu guibg=none]]

-- which key
vim.cmd [[hi WhichKeyFloat guibg=none]]
vim.cmd [[hi WhichKey guifg=orange]]
-- normal
vim.cmd [[hi FloatBorder guibg=none]]

vim.cmd [[hi GitSignsChange guifg=orange]]
vim.cmd [[hi GitSignsDelete guifg=red]]
vim.cmd [[hi GuihuaPanelLineNr guifg=orange]]
vim.cmd [[hi GuihuaBufferColon guifg=green]]
vim.cmd [[hi tsxTSComment guifg=green]]
vim.cmd [[hi TSComment guifg=gray]]
vim.cmd [[hi CursorLineNr guifg=orange]]
vim.cmd [[hi CmpBorder guifg='#5c6370']]

-- nvim tree
vim.cmd [[hi NvimTreeNormal guibg=#2c2d30]]
vim.cmd [[hi NvimTreeEndOfBuffer guibg=#2c2d30]]
vim.cmd [[hi NvimTreeWinSeparator guifg=#404247 guibg=#2c2d30]]
vim.cmd [[hi BufferLineIndicatorSelected guifg=orange]]
