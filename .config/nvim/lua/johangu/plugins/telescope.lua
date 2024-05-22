return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable 'make' == 1 end
    },
    -- 'AckslD/nvim-neoclip.lua',
  },
  config = function()
    local telescope = require 'telescope'
    -- telescope.load_extension('neoclip')
    local actions = require 'telescope.actions'
    local previewers = require 'telescope.previewers'
    local sorters = require 'telescope.sorters'

    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require 'telescope.builtin'.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzy search in current buffer' })
    vim.keymap.set('n', '<leader>sf', require 'telescope.builtin'.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', require 'telescope.builtin'.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sd', require 'telescope.builtin'.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sg', require 'telescope.builtin'.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sw', require 'telescope.builtin'.grep_string, { desc = '[S]earch current [W]ord' })

    telescope.setup {
      defaults = {
        file_ignore_patterns = { 'node_modules', 'coverage', 'lcov' },
        mappings = {
          n = {
            ['<ci-q>'] = actions.send_to_qflist + actions.open_qflist
          },
          i = {
            ['<C-u'] = false,
            ['<C-j'] = false,
          },
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
        spell_suggest = { theme = 'cursor' }
      }
    }
  end,
}
