local lsp_util = require("lin.utils.lsp")
local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

nvim_lsp.cssls.setup({
  capabilities = lsp_util.capabilities,
  on_attach = function(client, bufnr)
    lsp_util.on_attach(client, bufnr)
    -- disbale formatting, use eslint
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    css = { validate = false },
    scss = { validate = true },
    less = { validate = true },
  },
  root_dir = util.root_pattern(
    -- "stylelint.config.mjs",
    -- ".stylelintrc.json"
    ".git"
  ),
})
