local function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ''
  }
  vim.lsp.buf.execute_command(params)
end

local opts = {
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end
  },
  commands = {
    OrganizeImports = { organize_imports, description = 'Organize Imports' }
  }
}

return opts
