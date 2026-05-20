vim.opt.winborder = "rounded"

vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.shortmess:append("c")
vim.opt.pumheight = 10
-- vim.opt.pumblend = 10
vim.opt.wildignore = "tags,*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc,*.swp,*~,*/.DS_Store"
vim.opt.wildmode = "longest:full,full"
-- vim.opt.previewheight = 12

vim.opt.colorcolumn = "100"
vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.history = 50
vim.opt.lazyredraw = true

vim.opt.list = true
vim.opt.listchars = "tab:· ,eol:¬,trail:·,precedes:←,extends:→,nbsp:·,leadmultispace:┆"
vim.opt.matchpairs = "(:),{:},[:],<:>"

vim.opt.secure = true
vim.opt.showtabline = 2
vim.opt.sidescrolloff = 10
vim.opt.termguicolors = true
vim.opt.timeoutlen = 550
vim.opt.undofile = true
vim.opt.updatetime = 500

vim.opt.splitbelow = true
vim.opt.splitright = true

-- vim.g.spellfile_URL = "http://vim.mirror.garr.it/pub/vim/"
vim.opt.spelllang = { "en_gb", "sv", "es", "nl" }
vim.opt.spell = false
vim.opt.spelloptions = "camel"

vim.opt.isfname:append("@-@")

vim.filetype.add({
	pattern = {
		[".*/compose%.ya?ml"] = "yaml.docker-compose",
		[".*/docker%-compose%.ya?ml"] = "yaml.docker-compose",
		["%.env"] = "dosini",
		["%.env.*"] = "dosini",
	},
})
