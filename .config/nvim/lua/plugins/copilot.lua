local map = require'utils'.map
vim.g.copilot_filetypes = {
  ["*"] = false,
  ["bash"] = true,
  ["javascript"] = true,
  ["typescript"] = true,
  ["lua"] = false,
  ["rust"] = true,
  ["c"] = true,
  ["c#"] = true,
  ["c++"] = true,
  ["go"] = true,
  ["python"] = true,
}

vim.g.copilot_no_tab_map = true
map('i', '<C-j>', 'copilot#Accept("<CR>")')
