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
