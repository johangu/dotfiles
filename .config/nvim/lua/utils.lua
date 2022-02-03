local M = {}

_G.inspect = function(...) print(vim.inspect(...)) end

M.border = {
  {'╭', 'FloatBorder'},
  {'─', 'FloatBorder'},
  {'╮', 'FloatBorder'},
  {'│', 'FloatBorder'},
  {'╯', 'FloatBorder'},
  {'─', 'FloatBorder'},
  {'╰', 'FloatBorder'},
  {'│', 'FloatBorder'}
}

M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    vim.tbl_extend('force', options, opts)
  end
  local ok, error = pcall(vim.api.nvim_set_keymap, mode, lhs, rhs, options)
  if not ok then
    M.log_error('Keymap', error)
  end
end

M.buf_map = function(bufnr, mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    vim.tbl_extend('force', options, opts)
  end
  local ok, error = pcall(vim.api.nvim_buf_set_keymap, bufnr, mode, lhs, rhs, options)
  if not ok then
    M.log_error('Keymap', error)
  end
end

M.log_error = function(title, msg)
  vim.notify(msg, vim.log.levels.ERROR, {title=title})
end

M.log_warn = function(title, msg)
  vim.notify(msg, vim.log.levels.WARN, {title=title})
end

M.log_info = function(title, msg)
  vim.notify(msg, vim.log.levels.INFO, {title=title})
end

M.buf_opt = function(bufnr, ...) vim.api.nvim_buf_set_option(bufnr, ...) end

M.inspect = _G.inspect

M.preserve = function(command)
  local pos = vim.api.nvim_win_get_cursor(0)

  vim.cmd(command)

  vim.api.nvim_win_set_cursor(0, pos)
end

return M
