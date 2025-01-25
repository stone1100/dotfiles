local lsp_util = require("lin.utils.lsp")
local nvim_lsp = require("lspconfig")

-- INFO: Don't forget to install typescript language server itself
-- npm i -g typescript-language-server
-- override language server settings
nvim_lsp.ts_ls.setup({
  on_attach = function(client, bufnr)
    lsp_util.on_attach(client, bufnr)
    -- disbale formatting, use eslint
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  flags = { debounce_text_changes = 150 },
  capabilities = lsp_util.capabilities,
  filetypes = { "typescriptreact", "typescript" },
})
