-- require("core")

-- key mappings, more => lua/config/which-key.lua
require("mappings")
-- set nvim options
require("options")
-- plugin manager via packer
require("plugins")
-- nvim auto commands
require("autocmd")

vim.cmd([[colorscheme tokyonight]])

-- https://github.com/folke/tokyonight.nvim/pull/137#issuecomment-1016239546
-- improved telescope background
vim.cmd[[hi TelescopeNormal guibg=none]]
vim.cmd[[hi TelescopeBorder guibg=none]]
vim.cmd[[hi TelescopePromptTitle guifg=orange]]
vim.cmd[[hi TelescopePreviewTitle guifg=orange]]

vim.cmd[[hi LspFloatWinNormal guibg=none]]
vim.cmd[[hi BufferLineIndicatorSelected guifg=yellow]]
vim.cmd[[hi Comment guifg=gray]]
