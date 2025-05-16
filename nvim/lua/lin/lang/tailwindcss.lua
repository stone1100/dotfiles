local lsp_util = require("lin.utils.lsp")
local util = require("lspconfig/util")

vim.lsp.config("tailwindcss", {
  -- filetypes = { "typescriptreact", "typescript" },
  capabilities = lsp_util.capabilities,
  on_attach = lsp_util.on_attach,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local git_root = util.find_git_ancestor(fname)
    if git_root then
      --NOTE: fix monorepo
      on_dir(git_root)
    else
      on_dir(util.root_pattern("package.json"))
    end
  end,
  settings = {
    tailwindCSS = {
      includeLanguages = {
        templ = "html",
      },
    },
  },
})
