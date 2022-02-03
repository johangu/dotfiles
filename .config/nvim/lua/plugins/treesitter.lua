local log_error = require'utils'.log_error
local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  log_error('Plugin', 'Failed to load nvim-treesitter')
  return
end

configs.setup {
  autopairs = {enable = true},
  ensure_installed = 'maintained',
  highlight = {enable = true},
  indent = {enable = true, disable = {'yaml'}},
  -- rainbow = {enable = true, extended_mode = true},
  refactor = {highlight_definitions = {enable = true}}
}
