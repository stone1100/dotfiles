local api = vim.api

-- Create autocmd group
local function augroup(name)
  return api.nvim_create_augroup("linvim_" .. name, { clear = true })
end

-- api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
-- 	pattern = { "*.ts", "*.tsx", "*.js", "*.html" },
-- 	command = "setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab",
-- })

-- api.nvim_create_autocmd("VimEnter", {
-- 	group = augroup("hide_tumx_status"),
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd("silent !tmux set status off")
-- 	end,
-- })
--
-- api.nvim_create_autocmd("VimLeave", {
-- 	group = augroup("show_tumx_status"),
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd("silent !tmux set status on")
-- 	end,
-- })
