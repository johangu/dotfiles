local highlightYankGroup = vim.api.nvim_create_augroup('HighlightYank', {
  clear = true
})

vim.api.nvim_create_autocmd('TextYankPost', {
  command = "silent! lua vim.highlight.on_yank {higroup='Visual', timeout=250}",
  group = highlightYankGroup
})
