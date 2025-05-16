local signs = {
  [vim.diagnostic.severity.ERROR] = lin.options.icons.error,
  [vim.diagnostic.severity.WARN] = lin.options.icons.warn,
  [vim.diagnostic.severity.INFO] = lin.options.icons.info,
  [vim.diagnostic.severity.HINT] = lin.options.icons.hint,
}
vim.diagnostic.config({
  signs = {
    text = signs,
  },
  virtual_lines = true,
  virtual_text = false,
  -- virtual_text = {
  --   prefix = "",
  --   format = function(diagnostic)
  --     local icon = signs[diagnostic.severity]
  --     return string.format("%s %s", icon, diagnostic.message)
  --   end,
  -- },
  severity_sort = true,
})

vim.cmd([[
  highlight DiagnosticVirtualTextError guibg=NONE
  highlight DiagnosticVirtualTextWarn guibg=NONE
  highlight DiagnosticVirtualTextInfo guibg=NONE
  highlight DiagnosticVirtualTextHint guibg=NONE
]])
