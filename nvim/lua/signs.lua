local icons = require("icons")
vim.fn.sign_define('DiagnosticSignError', { text = icons.Error, texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = icons.Warn, texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = icons.Info, texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = icons.Hint, texthl = 'DiagnosticSignHint' })
vim.fn.sign_define('DapBreakpoint', { text = icons.Breakpoint, texthl = 'DapUIStop', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition',
	{ text = icons.BreakpointCondition, texthl = 'DapUIStop', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped',
	{ text = icons.BreakpointStop, texthl = 'DapUIBreakpointsCurrentLine', linehl = 'debugPC', numhl = 'debugPC' })
