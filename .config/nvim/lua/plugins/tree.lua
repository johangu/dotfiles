local log_error = require'utils'.log_error
local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  log_error('Plugin', 'Failed to load nvim-tree')
  return
end
local keymap = require'utils'.map

nvim_tree.setup {
  git_hl = true,
  diagnostics = {
    enable = true,
    icons = {hint = '', info = '', warning = '', error = ''}
  },
  filters = {custom = {'.git', 'node_modules', '.cache', 'coverage'}},
  quit_on_open = true,
  group_empty = true
}

keymap('n', '<leader>k', ':NvimTreeToggle<CR>')
