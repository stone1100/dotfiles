local lsp_util = require("lin.utils.lsp")

---@type vim.lsp.Config
return {
  root_dir = lsp_util.get_root_dir("package.json"),
}
