local indent = 2

local options = {
  autoindent = true,
  backspace = 'indent,eol,start',
  breakindent = true,
  cmdheight = 2,
  colorcolumn = '100',
  conceallevel = 0,
  cursorline = true,
  emoji = true,
  encoding = 'utf-8',
  fileencoding = 'utf-8',
  hidden = true,
  history = 50,
  hlsearch = true,
  ignorecase = true,
  incsearch = true,
  laststatus = 2,
  lazyredraw = true,
  list = true,
  listchars = 'tab:· ,eol:¬,trail:·,precedes:←,extends:→,nbsp:·',
  matchpairs = '(:),{:},[:],<:>',
  pumheight = 10,
  ruler = true,
  scrolloff = 10,
  secure = true,
  showcmd = true,
  showtabline = 2,
  sidescrolloff = 10,
  smartcase = true,
  smartindent = true,
  spelllang = 'en_us',
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  timeoutlen = 550,
  undofile = true,
  updatetime = 500,
  wildignore = 'tags,*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc,*.swp,*~,*/.DS_Store',
  wildmenu = true,
  wildmode = 'longest:full,full',
  shiftwidth = indent,
  softtabstop = indent,
  tabstop = indent,
  number = true,
  numberwidth = 3,
  signcolumn = 'yes',
  wrap = true
}

for key, value in pairs(options) do vim.opt[key] = value end

vim.opt.shortmess:append 'c'
vim.opt.completeopt = 'menu,menuone,noselect'

vim.cmd 'filetype plugin indent on'

-- disable some builtin vim plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin'
}

for _, plugin in pairs(disabled_built_ins) do vim.g['loaded_' .. plugin] = 1 end

