local log_error = require'utils'.log_error
local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  log_error('Plugin', 'Failed to load colorizer')
  return
end

local keymap = require'utils'.map
local actions = require 'telescope.actions'
local previewers = require 'telescope.previewers'
local sorters = require 'telescope.sorters'

telescope.load_extension('neoclip')

keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
keymap('n', '<leader>fF', '<cmd>Telescope git_files<cr>')
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
keymap('n', '<leader>ft', '<cmd>Telescope treesitter<cr>')
keymap('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>')
keymap('n', '<leader>fv', '<cmd>Telescope neoclip<cr>')

telescope.setup {
  defaults = {
    file_ignore_patterns = { 'node_modules', 'coverage', 'lcov' },
    mappings = {
      n = {
        ['<ci-q>'] = actions.send_to_qflist + actions.open_qflist
      }
    },
    prompt_prefix = '   ',
    selection_caret = ' ',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8
      },
      vertical = { mirror = false },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120
    },
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    path_display = { 'absolute' },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = previewers.buffer_previewer_maker
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      theme = 'dropdown',
      mappings = {
        n = { ['<c-d>'] = actions.delete_buffer },
        i = { ['<c-d>'] = actions.delete_buffer },
      }
    },
    lsp_code_actions = { theme = 'cursor' },
    lsp_range_code_actions = { theme = 'cursor' }
  }
}
