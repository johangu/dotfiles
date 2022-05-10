local u = require 'utils'
local handlers = require 'lsp.handlers'

local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  u.log_error('Require', 'Failed to load nvim-lsp-installer')
  return
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = handlers.make_client_capabilities(),
    on_attach = handlers.on_attach,
    on_init = handlers.on_init
  }

  local server_status_ok, server_opts = pcall(require, 'lsp.settings.'..server.name)
  if server_status_ok then
    opts = vim.tbl_extend('force', server_opts, opts)
  end

  server:setup(opts)
end)
