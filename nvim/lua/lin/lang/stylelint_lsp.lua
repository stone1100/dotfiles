local lsp_util = require("lin.utils.lsp")
local util = require("lspconfig/util")

vim.lsp.config("stylelint_lsp", {
  capabilities = lsp_util.capabilities,
  on_attach = lsp_util.on_attach,
  filetypes = {
    "css",
    "less",
    "scss",
  },
  root_dir = util.root_pattern(
    -- "stylelint.config.mjs",
    -- ".stylelintrc.json"
    ".git"
  ),
  settings = {
    stylelintplus = {
      -- see available options in stylelint-lsp documentation
      autoFixOnSave = true,
      autoFixOnFormat = true,
    },
  },
})
