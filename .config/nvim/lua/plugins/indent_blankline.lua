return {
  'lukas-reineke/indent-blankline.nvim',
  opts = {
    filetype_exclude = { 'help', 'terminal', 'dashboard', 'packer' },
    buftype_exclude = { 'terminal' },
    show_current_context = true,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    use_treesitter = true
  }
}
