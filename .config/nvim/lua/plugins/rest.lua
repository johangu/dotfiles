local u = require 'utils'
local log_error = u.log_error
local map = u.map
local status_ok, rest = pcall(require, 'rest-nvim')
if not status_ok then
  log_error('Plugin', 'Failed to load rest')
  return
end

rest.setup({
  result_split_horizontal = false,
  skip_ssl_verification = true,
  highlight = {
    enable = true,
    timeout = 150
  },
  result = {
    show_url = true,
    show_http_info = true,
    show_headers = true
  },
  env_file = '.env'
})

vim.cmd("command! RestNvim lua require('rest-nvim').run()")
map('n', '<leader>r', ':RestNvim<CR>')
