vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.conceallevel = 2
vim.opt_local.foldenable = false
vim.g.vim_markdown_fenced_languages = {
  'html',
  'python',
  'bash=sh',
  'javascript'
}
vim.g.vim_markdown_frontmatter = 1 -- for YAML format
vim.g.vim_markdown_toml_frontmatter = 1 -- for TOML format
vim.g.vim_markdown_json_frontmatter = 1 -- for JSON format

local group = vim.api.nvim_create_augroup('MarkdownSpelling', { clear = true })

vim.api.nvim_create_autocmd({'BufEnter', 'BufCreate'}, {
  pattern = {'*.md'},
  command = 'lua vim.wo.spell = true',
  group = group
})
vim.api.nvim_create_autocmd({'BufLeave'}, {
  pattern = {'*.md'},
  command = 'lua vim.wo.spell = false',
  group = group
})
