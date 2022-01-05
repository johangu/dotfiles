local u = require 'utils'

local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  u.log_error('Require', 'Failed to load lspconfig')
  return
end

require'lsp.lsp-installer'
require'lsp.handlers'.setup()
