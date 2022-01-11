local M = {}
local u = require 'utils'
local capabilities = vim.lsp.protocol.make_client_capabilities()
--[[ capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.colorProvider = {dynamicRegistration = false} ]]

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
  u.log_error('Require', 'Could not load cmp_nvim_lsp')
  return
end

local goto_definition = function(split_cmd)
  local util = vim.lsp.util
  local log = require('vim.lsp.log')
  local api = vim.api

  local handler = function(_, method, result)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(method, 'No location found')
      return nil
    end

    if split_cmd then vim.cmd(split_cmd) end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command('copen')
        api.nvim_command('wincmd p')
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

local function register_commands()
  vim.cmd('command! LspDef lua vim.lsp.buf.definition()')
  vim.cmd('command! LspDeclaration lua vim.lsp.buf.declaration()')
  vim.cmd('command! LspFormatting lua vim.lsp.buf.formatting()')
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

local function lsp_keymaps(bufnr)
  u.buf_map(bufnr, 'n', 'gD', ':LspDeclaration<CR>')
  u.buf_map(bufnr, 'n', 'gd', ':LspDef<CR>')
  u.buf_map(bufnr, 'n', 'gy', ':LspTypeDef<CR>')
  u.buf_map(bufnr, 'n', 'gR', ':LspRename<CR>')
  u.buf_map(bufnr, 'n', 'gr', ':LspRefs<CR>')
  u.buf_map(bufnr, 'n', 'K', ':LspHover<CR>')
  u.buf_map(bufnr, 'n', 'gi', ':LspImplementation<CR>')
  u.buf_map(bufnr, 'n', '<C-k>', ':LspSignatureHelp<CR>')
  u.buf_map(bufnr, 'n', '[d', ':LspDiagNext<CR>')
  u.buf_map(bufnr, 'n', ']d', ':LspDiagPrev<CR>')
  u.buf_map(bufnr, 'n', '<leader>[', ':LspDiagLine<CR>')
  u.buf_map(bufnr, 'n', '<leader>ca', ':CodeActionMenu<CR>')
  u.buf_map(bufnr, 'x', '<leader>ca', ':LspRangeCodeAction<CR>')

  u.buf_map(bufnr, 'n', '<leader>wa', ':LspAddWorkspaceFolder<CR>')
  u.buf_map(bufnr, 'n', '<leader>wr', ':LspRemoveWorkspaceFolder<CR>')
  u.buf_map(bufnr, 'n', '<leader>wl', ':LspListWorkspaceFolders<CR>')
  u.buf_map(bufnr, 'n', '<leader>ll', ':LspListDiagnostics<CR>')
end

local lsp_highlight_document = function(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightGray guifg=Black
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightGray guifg=Black
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightGray guifg=Black
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
  end
end

M.setup = function()
  local signs = {
    { name = 'Error', text = nil },
    { name = 'Information', text = nil },
    { name = 'Info', text = nil },
    { name = 'Warning', text = nil },
    { name = 'Warn', text = nil },
    { name = 'Hint', text = nil }
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define('DiagnosticSign' .. sign.name, {
      text = sign.text,
      numhl = 'Diagnostic' .. sign.name,
      linehl = 'Diagnostic' .. sign.name
    })
  end

  vim.lsp.handlers['textDocument/definition'] = goto_definition('vsplit')
  vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = u.border })
  vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = u.border })
  vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = false,
      virtual_text = false,
      signs = true,
      update_in_insert = true,
      severity_sort = true
    })

  register_commands()
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

M.on_attach = function(client, bufnr)
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
    -- vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
  elseif client.name == 'eslint' then
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  -- u.buf_opt(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
         augroup END
         ]], true)
  end
end

M.on_init = function(client)
  if client.config.flags then client.config.flags.allow_incremental_sync = true end
end

return M
