local lsp_util = require("lin.utils.lsp")
local nvim_lsp = require("lspconfig")

-- INFO: Don't forget to install typescript language server itself
-- npm i -g typescript-language-server
-- override language server settings
nvim_lsp.tsserver.setup({
  on_attach = lsp_util.on_attach,
  flags = { debounce_text_changes = 150 },
  capabilities = lsp_util.capabilities,
  filetypes = { "typescriptreact", "typescript" },
  settings = {
    tsserver = {
      format = { enable = false },
    },
  },
})
