-- Highlight on yank
vim.cmd[[
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank {higroup="Visual", timeout=200}
augroup END 
]]

-- change to below with nvim 0.7.x
--[[
local highlightYankGroup = vim.api.nvim_create_augroup('HighlightYank', { clear = true})
vim.api.nvim_create_autocmd('TextYankPost', { command = "silent! lua vim.highlight.on_yank {higroup='Visual', timeout=200}", group = highlightYankGroup }) ]]
