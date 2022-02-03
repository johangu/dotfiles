local u = require 'utils'
local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  u.log_error('Require', 'Failed to load dap')
  return
end

dap.set_log_level 'TRACE'

vim.fn.sign_define('DapBreakpoint', {
  text = '■',
  texthl = 'debugBreakpoint',
  linehl = '',
  numhl = 'debugBreakpoint'
})
vim.fn.sign_define('DapStopped', {
  text = '◆',
  texthl = 'debugPC',
  linehl = '',
  numhl = 'debugPC'
})

u.map('n', '<F5>', ':lua require\'dap\'.continue()')
u.map('n', '<F10>', ':lua require\'dap\'.step_over()')
u.map('n', '<F11>', ':lua require\'dap\'.step_into()')
u.map('n', '<leader>db', ':lua require\'dap\'.toggle_breakpoint()<cr>')
u.map('n', '<leader>dB',
      ':lua require\'dap\'.set_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<cr>')
u.map('n', '<leader>dr', ':lua require\'dap\'.repl_open()<cr>')
