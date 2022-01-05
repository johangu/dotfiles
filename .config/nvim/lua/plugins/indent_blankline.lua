local log_error = require'utils'.log_error
local status_ok, indent_blankline = pcall(require, 'indent_blankline')
if not status_ok then
  log_error('Plugin', 'Failed to load indent_blankline')
  return
end

indent_blankline.setup {
  filetype_exclude = {'help', 'terminal', 'dashboard', 'packer'},
  buftype_exclude = {'terminal'},
  context_patterns = {
    'class',
    'return',
    'function',
    'method',
    '^if',
    '^while',
    '^for',
    'with',
    'func_literal',
    'if_statement',
    'try_statement',
    'catch_clause',
    'import_statement',
    'else_clause',
    'block',
    'try',
    'except',
    'argument_list',
    'object',
    'dictionary'
  },
  show_current_context = true,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  use_treesitter = true
}
