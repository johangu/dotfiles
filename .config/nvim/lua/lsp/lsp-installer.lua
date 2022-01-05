local u = require 'utils'
local handlers = require'lsp.handlers'

local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  u.log_error('Require', 'Failed to load nvim-lsp-installer')
  return
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = handlers.capabilities,
    on_attach = handlers.on_attach,
    on_init = handlers.on_init
  }

  if server.name == 'eslint' then
    local eslint_opts = require'lsp.settings.eslint'
    opts = vim.tbl_extend('force', eslint_opts, opts)
  end

  if server.name == 'jsonls' then
    local jsonls_opts = require'lsp.settings.jsonls'
    opts = vim.tbl_extend('force', jsonls_opts, opts)
  end

  if server.name == 'sumneko_lua' then
    local sumneko_lua_opts = require'lsp.settings.sumneko_lua'
    opts = vim.tbl_extend('force', sumneko_lua_opts, opts)
  end

  server:setup(opts)
end)
