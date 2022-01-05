local log_error = require'utils'.log_error
local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  log_error('Plugin', 'Failed to load nvim-tree')
  return
end
local keymap = require'utils'.map

nvim_tree.setup {
  auto_close = true,
  diagnostics = {
    enable = false,
    icons = {hint = '', info = '', warning = '', error = ''}
  },
  filters = {custom = {'.git', 'node_modules', '.cache', 'coverage'}}
}
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1

keymap('n', '<leader>k', ':NvimTreeToggle<CR>')
