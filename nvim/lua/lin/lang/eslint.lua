local lsp_util = require("lin.utils.lsp")
local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

nvim_lsp.eslint.setup({
  capabilities = lsp_util.capabilities,
  on_attach = lsp_util.on_attach,
  root_dir = util.root_pattern(
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.cjs",
    "eslint.config.mjs",
    "eslint.config.js"
    -- Disabled to prevent "No ESLint configuration found" exceptions
    -- 'package.json',
  ),
})
