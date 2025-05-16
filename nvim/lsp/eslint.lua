local lsp_util = require("lin.utils.lsp")
return {
  root_dir = lsp_util.get_root_dir("package.json"),
}
