local lsp_util = require("lin.utils.lsp")
local util = require("lspconfig/util")

vim.lsp.config("eslint", {
  capabilities = lsp_util.capabilities,
  on_attach = lsp_util.on_attach,
  root_dir = util.root_pattern(
    --NOTE: just for git repo, because monorepo only start one eslint server for diff root
    ".git"
    -- ".eslintrc.js",
    -- ".eslintrc.cjs",
    -- ".eslintrc.yaml",
    -- ".eslintrc.yml",
    -- ".eslintrc.json",
    -- "eslint.config.cjs",
    -- "eslint.config.mjs",
    -- "eslint.config.js"
    -- Disabled to prevent "No ESLint configuration found" exceptions
    -- 'package.json',
  ),
})
