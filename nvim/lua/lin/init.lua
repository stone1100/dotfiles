vim.uv = vim.uv or vim.loop

local M = {}

-- Setup Lin NVIM
---@param opts? LinVimConfig
function M.setup(opts)
  require("lin.config").setup(opts)
end

return M
