-- more mappings are defined in `lua/config/which-key.lua`
local map = vim.keymap.set

--Remap space as leader key
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
