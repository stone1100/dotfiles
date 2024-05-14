vim.fn.sign_define("DiagnosticSignError", { text = lin.options.icons.error, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = lin.options.icons.warn, texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = lin.options.icons.info, texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = lin.options.icons.hint, texthl = "DiagnosticSignHint" })
vim.fn.sign_define(
  "DapBreakpoint",
  { text = lin.options.icons.breakpoint, texthl = "DapUIStop", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = lin.options.icons.breakpoint_condition, texthl = "DapUIStop", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapStopped", {
  text = lin.options.icons.breakpoint_stop,
  texthl = "DapUIBreakpointsCurrentLine",
  linehl = "debugPC",
  numhl = "debugPC",
})
