local api = vim.api

-- Create autocmd group
local function augroup(name)
  return api.nvim_create_augroup("linvim_" .. name, { clear = true })
end

if lin.options.cursor_sign then
  -- define sign
  vim.fn.sign_define("CursorLineSign", { text = "󰼛", texthl = "TelescopeSelectionCaret" })
  local current_line_sign_id = 12345 -- sign id

  local function toggle_cursor_line_sign()
    local win_config = vim.api.nvim_win_get_config(0)
    if win_config.relative ~= "" then
      -- float window
      return
    end
    local bufnr = vim.api.nvim_get_current_buf()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    -- move old sign if exit
    vim.fn.sign_unplace("CursorLineSignGroup", { buffer = bufnr, id = current_line_sign_id })
    -- set new sign
    vim.fn.sign_place(current_line_sign_id, "CursorLineSignGroup", "CursorLineSign", bufnr, { lnum = line })
  end

  -- auto cmd for cursor sign
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter", "InsertLeave" }, {
    group = augroup("cursor_sign"),
    pattern = "*",
    callback = toggle_cursor_line_sign,
  })
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
--
vim.api.nvim_create_user_command("PrintGoplsConfig", function()
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    if client.name == "gopls" then
      print(vim.inspect(client.config))
    end
  end
end, {})
