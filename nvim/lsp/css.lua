local lsp_util = require("lin.utils.lsp")
return {
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
  root_dir = lsp_util.root_pattern(".git"),
}
