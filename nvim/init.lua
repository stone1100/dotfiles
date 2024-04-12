-- ref: https://github.com/Allaman/nvim
-- lua print(vim.fn.stdpath('data'))

-- change language
-- https://vi.stackexchange.com/questions/36426/how-do-i-change-my-language-in-my-init-lua-neovim
vim.api.nvim_exec('language en_US', true)

-- key mappings, more => lua/config/which-key.lua
require("mappings")
-- set nvim options
require("options")
-- plugin manager via packer
require("plugins")
-- nvim auto commands
require("autocmd")
-- theme/highlight
require("highlight")
-- signs
require("signs")
