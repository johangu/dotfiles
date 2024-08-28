vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "100"
vim.opt.completeopt = "menuone,noselect"
vim.opt.cursorline = true
vim.opt.emoji = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.hidden = true
vim.opt.history = 50
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = "tab:· ,eol:¬,trail:·,precedes:←,extends:→,nbsp:·"
vim.opt.matchpairs = "(:),{:},[:],<:>"
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.scrolloff = 15
vim.opt.secure = true
vim.opt.shiftwidth = 2
vim.opt.showcmd = true
vim.opt.showtabline = 2
vim.opt.sidescrolloff = 10
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 550
vim.opt.undofile = true
vim.opt.updatetime = 500
vim.opt.wildignore = "tags,*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc,*.swp,*~,*/.DS_Store"
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.numberwidth = 3
vim.opt.wrap = true

-- vim.g.spellfile_URL = "http://vim.mirror.garr.it/pub/vim/"
vim.opt.spelllang = { "en_gb", "sv", "es", "nl" }
vim.opt.spell = false

vim.wo.number = true
vim.wo.signcolumn = "yes"

vim.opt.shortmess:append("c")
vim.opt.isfname:append("@-@")

vim.cmd("filetype plugin indent on")

-- disable some builtin vim plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
