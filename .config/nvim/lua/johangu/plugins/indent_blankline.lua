return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require 'ibl'.setup({
      exclude = {
        filetypes = {
          'TelescopePrompts',
          'TelescopeResults',
          'dashboard',
          'man',
          'gitcommit',
          'checkhealth',
          'help',
          'lazy',
          'lspinfo',
          'mason',
          'terminal',
        },
      },
      indent = {
        char = "┊",
        tab_char = "┊",
      },
      scope = {
        enabled = true,
        highlight = "RainbowDelimiterBlue",
        -- highlight = "RainbowDelimiterOrange",
        show_end = false,
      },
    })
    local hooks = require 'ibl.hooks'
    hooks.register(
      hooks.type.WHITESPACE,
      hooks.builtin.hide_first_tab_indent_level
    )
    hooks.register(
      hooks.type.WHITESPACE,
      hooks.builtin.hide_first_space_indent_level
    )
    hooks.register(
      hooks.type.SCOPE_HIGHLIGHT,
      hooks.builtin.scope_highlight_from_extmark
    )
  end,
  dependencies = {
    'HiPhish/rainbow-delimiters.nvim',
  },
}
