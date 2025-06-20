local lsp_util = require("lin.utils.lsp")

---@type vim.lsp.Config
return {
  -- filetypes = { "typescriptreact", "typescript" },
  -- capabilities = lsp_util.capabilities,
  -- on_attach = lsp_util.on_attach,
  root_dir = lsp_util.get_root_dir("package.json"),
}
