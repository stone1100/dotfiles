local lsp_util = require("lin.utils.lsp")
-- override language server settings
return {
  on_attach = lsp_util.on_attach,
  flags = { debounce_text_changes = 150 },
  capabilities = lsp_util.capabilities,
  settings = {
    -- ref: https://github.com/golang/tools/blob/master/gopls/doc/vim.md
    gopls = {
      usePlaceholders = true,
      staticcheck = true,
      gofumpt = true,
      analyses = {
        -- fieldalignment = true, //removed by gopls v0.17.0
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusewrites = true,
      },
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
