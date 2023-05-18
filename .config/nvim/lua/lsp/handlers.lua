local M = {}
local u = require 'utils'

local function goto_definition(split_cmd)
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


local function lsp_highlight_document(client)
  local auGroup = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd('CursorHold', {
      callback = vim.schedule_wrap(vim.lsp.buf.document_highlight),
      desc = 'Highlight word under the cursor',
      group = auGroup
    })
    vim.api.nvim_create_autocmd('CursorHoldI', {
      callback = vim.schedule_wrap(vim.lsp.buf.signature_help),
      desc = 'Show signature help for word under the cursor',
      group = auGroup
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = vim.schedule_wrap(vim.lsp.buf.clear_references),
      desc = 'Clear references when moving cursor',
      group = auGroup
    })

    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightGray guifg=Black
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightGray guifg=Black
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightGray guifg=Black
    ]], false)
  end
end

M.on_attach = function(client, bufnr)
  lsp_highlight_document(client)
end

return M
