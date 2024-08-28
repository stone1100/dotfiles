local lsp_util = require("lin.utils.lsp")
local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

nvim_lsp.stylelint_lsp.setup({
  capabilities = lsp_util.capabilities,
  on_attach = lsp_util.on_attach,
  filetypes = {
    "css",
    "less",
    "scss",
  },
  root_dir = util.root_pattern("stylelint.config.mjs", ".stylelintrc.json"),
})
