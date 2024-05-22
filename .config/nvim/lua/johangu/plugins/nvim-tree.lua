return {
  'kyazdani42/nvim-tree.lua',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  keys = {
    { '<leader>k', function() require 'nvim-tree.api'.tree.toggle() end, desc = 'Toggle nvim-tree' }
  },
  config = function()
    require 'nvim-tree'.setup {
      actions = {
        open_file = {
          quit_on_open = false
        }
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = '',
          info = '',
          warning = '',
          error = ''
        }
      },
      filters = {
        custom = {
          '^.cache',
          '^.git$',
          '^.pyc',
          'coverage',
          'node_modules',
        },
      },
    }
  end,
}
