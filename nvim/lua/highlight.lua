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
vim.cmd [[hi TelescopePromptPrefix guifg=orange]]
vim.cmd [[hi TelescopePreviewTitle guifg=orange]]
vim.cmd [[hi TelescopeSelectionCaret guifg=orange]]

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
vim.cmd [[hi CmpItemKindText guibg=NONE guifg=#F79000 ]]
-- nvim tree
vim.cmd [[hi NvimTreeNormal guibg=#2c2d30]]
vim.cmd [[hi NvimTreeEndOfBuffer guibg=#2c2d30]]
vim.cmd [[hi NvimTreeWinSeparator guifg=#404247 guibg=#2c2d30]]
vim.cmd [[hi BufferLineIndicatorSelected guifg=orange]]

-- todo
vim.cmd [[hi TodoBgTODO guibg=#99bc80 guifg=#5c6370]]
vim.cmd [[hi TodoFgTODO guifg=#99bc80]]
vim.cmd [[hi TodoSignTODO guifg=#99bc80]]
-- notify
vim.cmd [[hi NotifyERRORBorder guifg=#8A1F1F]]
vim.cmd [[hi NotifyWARNBorder guifg=#79491D]]
vim.cmd [[hi NotifyINFOBorder guifg=#A9FF68]]
vim.cmd [[hi NotifyDEBUGBorder guifg=#8B8B8B]]
vim.cmd [[hi NotifyTRACEBorder guifg=#4F3552]]
vim.cmd [[hi NotifyERRORIcon guifg=#F70067]]
vim.cmd [[hi NotifyWARNIcon guifg=#F79000]]
vim.cmd [[hi NotifyINFOIcon guifg=#A9FF68]]
vim.cmd [[hi NotifyDEBUGIcon guifg=#8B8B8B]]
vim.cmd [[hi NotifyTRACEIcon guifg=#D484FF]]
vim.cmd [[hi NotifyERRORTitle  guifg=#F70067]]
vim.cmd [[hi NotifyWARNTitle guifg=#F79000]]
vim.cmd [[hi NotifyINFOTitle guifg=#A9FF68]]
vim.cmd [[hi NotifyDEBUGTitle  guifg=#8B8B8B]]
vim.cmd [[hi NotifyTRACETitle  guifg=#D484FF]]

vim.cmd [[hi Visual term=reverse cterm=reverse guibg=#7c6f64]]
vim.cmd [[hi DiagnosticWarn ctermfg=3 guifg=#debf81]]

-- lsp
vim.cmd [[hi LspInfoBorder guifg='#5c6370']]

-- quicklist
vim.cmd [[hi qfFileName guifg=#b1b4b9]]
vim.cmd [[hi QuickFixLine guifg=#F79000]]

-- smoot cursor
vim.cmd [[hi SmoothCursor guifg=#F79000]]

-- coverage
vim.cmd([[
        hi CoverageCovered guifg=#87AF87
        hi CoverageUncovered guifg=#f07178
        hi CoveragePartial guifg=#aa71f0
        hi CoverageSummaryHeader gui=bold,underline guisp=fg
        hi! link CoverageSummaryBorder FloatBorder
        hi! link CoverageSummaryNormal NormalFloat
        hi! link CoverageSummaryCursorLine CursorLine
        hi! link CoverageSummaryPass CoverageCovered
        hi! link CoverageSummaryFail CoverageUncovered
      ]])
