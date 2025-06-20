local lsp_util = require("lin.utils.lsp")

---@type vim.lsp.Config
return {
  filetypes = {
    "css",
    "less",
    "scss",
  },
  root_dir = lsp_util.get_root_dir("package.json"),
  settings = {
    stylelintplus = {
      -- see available options in stylelint-lsp documentation
      autoFixOnSave = true,
      autoFixOnFormat = true,
    },
  },
}
