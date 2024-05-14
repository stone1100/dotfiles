-- ref: https://github.com/Allaman/nvim
-- lua print(vim.fn.stdpath('data'))

-- change language
-- https://vi.stackexchange.com/questions/36426/how-do-i-change-my-language-in-my-init-lua-neovim
vim.api.nvim_exec("language en_US", true)

-- more mappings are defined in `lua/config/which-key.lua`
local map = vim.keymap.set

--Remap space as leader key
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

local opt = vim.o

opt.cursorline = true -- Enable highlighting of the current line
opt.cursorcolumn = true
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
-- opt.softtabstop = 0
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.spelllang = "en"
opt.termguicolors = true -- True color support
opt.wrap = false -- Disable line wrap
opt.foldmethod = "manual"
opt.undofile = true
opt.autoindent = true
opt.timeoutlen = 1000
opt.ruler = false
opt.winblend = 15 -- float winblend
opt.pumblend = 15 -- popup-menu winblend
opt.loaded_netrw = 0
-- opt.clipboard = "unnamedplus"
opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- vim.cmd("syntax off")
vim.cmd([[set colorcolumn=120]])
