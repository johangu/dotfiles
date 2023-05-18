local on_init = function(client)
  if client.config.flags then client.config.flags.allow_incremental_sync = true end
end

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  nmap('<leader>ll', ':LspListDiagnostics<CR>')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

require 'neodev'.setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {}

mason_lspconfig.setup_handlers {
  function(server_name)
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
      on_init = on_init
    }

    local server_status_ok, server_opts = pcall(require, 'lsp.settings.' .. server_name)
    if server_status_ok then
      opts = vim.tbl_extend('force', server_opts, opts)
    end

    require('lspconfig')[server_name].setup(opts)
  end
}

local function register_commands()
  vim.cmd('command! LspDef lua vim.lsp.buf.definition()')
  vim.cmd('command! LspDeclaration lua vim.lsp.buf.declaration()')
  vim.cmd('command! LspFormatting lua vim.lsp.buf.format({async = true})')
  vim.cmd('command! LspCodeAction lua vim.lsp.buf.code_action()')
  vim.cmd('command! LspRangeCodeAction lua vim.lsp.buf.range_code_action()')
  vim.cmd('command! LspHover lua vim.lsp.buf.hover()')
  vim.cmd('command! LspRename lua vim.lsp.buf.rename()')
  vim.cmd('command! LspRefs lua vim.lsp.buf.references()')
  vim.cmd('command! LspTypeDef lua vim.lsp.buf.type_definition()')
  vim.cmd('command! LspImplementation lua vim.lsp.buf.implementation()')
  vim.cmd(
    'command! LspDiagPrev lua vim.diagnostic.goto_prev({ wrap = false, popup_opts = { border = require\'utils\'.border, focusable = false }})')
  vim.cmd(
    'command! LspDiagNext lua vim.diagnostic.goto_next({ wrap = false, popup_opts = { border = require\'utils\'.border, focusable = false }})')
  vim.cmd(
    'command! LspDiagLine lua vim.diagnostic.open_float({ show_header = true, border = require\'utils\'.border, focusable = false })')
  vim.cmd('command! LspSignatureHelp lua vim.lsp.buf.signature_help()')
  vim.cmd(
    'command! LspAddWorkspaceFolder lua vim.lsp.buf.add_workspace_folder()')
  vim.cmd(
    'command! LspRemoveWorkspaceFolder lua vim.lsp.buf.remove_workspace_folder()')
  vim.cmd(
    'command! LspListWorkspaceFolders lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))')
  vim.cmd('command! LspListDiagnostics lua vim.diagnostic.set_loclist()')
end
