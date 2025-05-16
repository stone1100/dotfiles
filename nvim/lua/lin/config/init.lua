---@class LinVim global
---@field version string
---@field options LinVimOptions
---@field utils lin.utils
_G.lin = {}
---@class LinVimConfig: LinVimOptions
---fdsf
local M = {}
lin.version = "0.0.1" -- x-release-please-version
local function setupPlugins()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    spec = {
      { import = "lin.plugins" },
    },
    ui = {
      border = "single",
      backdrop = 100,
    },
    install = {
      -- try to load one of these colorschemes when starting an installation during startup
      colorscheme = { "tokyonight-storm" },
    },
    performance = {
      rtp = {
        reset = false,
      },
    },
  })
end

---@param opts? LinVimOptions
function M.setup(opts)
  -- parse opts
  local defaults = require("lin.config.config").defaults
  local options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}
  -- set lin global vars
  lin.options = options
  -- set utils tool
  lin.utils = require("lin.utils")

  -- NOTE: first must load nvim options
  require("lin.config.options")

  -- setup plugins
  setupPlugins()

  -- load nvim lighlights
  require("lin.config.highlights")
  -- load nvim signs
  require("lin.config.signs")
  require("lin.config.diagnostic")
  -- load nvim autocmds
  require("lin.config.autocmds")
  -- keymaps
  require("lin.config.keymaps")
end

return M
