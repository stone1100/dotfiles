local lsp_util = require("lin.utils.lsp")

return {
  capabilities = lsp_util.capabilities,
  on_attach = lsp_util.on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim", "packer_plugins" } },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      telemetry = { enable = false },
      format = { enable = true },
    },
  },
}
