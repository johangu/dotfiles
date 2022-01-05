local log_error = require'utils'.log_error
local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  log_error('Plugin', 'Failed to load lualine')
  return
end

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = '', warn = '', info = '' }
}

local diff = {
  'diff',
  symbols = { added = ' ', modified = ' ', removed = ' ' } -- changes diff symbols
}

local branch = { 'branch', icon = '' }

local progress = function()
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  local chars = {
    '__',
    '▁▁',
    '▂▂',
    '▃▃',
    '▄▄',
    '▅▅',
    '▆▆',
    '▇▇',
    '██'
  }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
  if vim.api.nvim_buf_get_option(0, 'expandtab') then
    return 'spaces: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
  else
    return 'tabs'
  end
end

local mode = { function() return '' end, padding = {left = 1, right = 1} }

lualine.setup {
  options = {
    component_separators = '',
    icons_enabled = true,
    section_separators = '',
    theme = 'tokyonight'
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diff },
    lualine_c = {
      { 'filename', file_status = true, full_path = true },
      diagnostics
    },
    lualine_x = { spaces, 'encoding', 'filetype', 'fileformat' },
    lualine_y = { { 'location', padding = 0 } },
    lualine_z = { progress }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  }
}
