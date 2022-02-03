local keymap = require'utils'.buf_map

vim.opt_local.autoindent = true
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt.smarttab = true
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4
vim.opt_local.textwidth = 79
vim.opt_local.colorcolumn = '80'
vim.opt_local.fileformat = 'unix'

keymap(vim.fn.bufnr(), 'n', '<F5>', ':w<CR>:exec "!python" shellescape(@%, 1)<CR>')
keymap(vim.fn.bufnr(), 'i', '<F5>', '<esc>:w<CR>:exec "!python" shellescape(@%, 1)<CR>')
