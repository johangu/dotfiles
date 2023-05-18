return {
  'kyazdani42/nvim-tree.lua',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require 'nvim-tree'.setup {
      actions = {
        open_file = {
          quit_on_open = true
        }
      },
      diagnostics = {
        enable = true,
        icons = { hint = '', info = '', warning = '', error = '' }
      },
      filters = { custom = { '.git', 'node_modules', '.cache', 'coverage' } }
    }
    vim.keymap.set('n', '<leader>k', ':NvimTreeToggle<CR>', { desc = 'Toggle nvim-tree' })
  end,
}
