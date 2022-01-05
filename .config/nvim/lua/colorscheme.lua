vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_sidebars = {
  'qf',
  'vista_kind',
  'terminal',
  'packer',
  'nvim_tree'
}
vim.cmd [[
try
  colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
