-- Config diagnostics
local signs = {
	{ name = "Error", text = nil },
	{ name = "Information", text = nil },
	{ name = "Info", text = nil },
	{ name = "Warning", text = nil },
	{ name = "Warn", text = nil },
	{ name = "Hint", text = nil },
}
for _, sign in ipairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. sign.name, {
		text = sign.text,
		numhl = "Diagnostic" .. sign.name,
		linehl = "Diagnostic" .. sign.name,
	})
end

vim.diagnostic.config({
	underline = false,
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	severity_sort = true,
})

local options = {
	autoindent = true,
	backspace = "indent,eol,start",
	breakindent = true,
	cmdheight = 1,
	colorcolumn = "100",
	completeopt = "menuone,noselect",
	cursorline = true,
	emoji = true,
	encoding = "utf-8",
	fileencoding = "utf-8",
	hidden = true,
	history = 50,
	hlsearch = false,
	ignorecase = true,
	incsearch = true,
	laststatus = 2,
	lazyredraw = true,
	list = true,
	listchars = "tab:· ,eol:¬,trail:·,precedes:←,extends:→,nbsp:·",
	matchpairs = "(:),{:},[:],<:>",
	pumheight = 10,
	relativenumber = true,
	ruler = true,
	scrolloff = 15,
	secure = true,
	shiftwidth = 2,
	showcmd = true,
	showtabline = 2,
	sidescrolloff = 10,
	smartcase = true,
	smartindent = true,
	spelllang = "en_gb",
	splitbelow = true,
	splitright = true,
	softtabstop = 2,
	tabstop = 2,
	termguicolors = true,
	timeout = true,
	timeoutlen = 550,
	undofile = true,
	updatetime = 500,
	wildignore = "tags,*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc,*.swp,*~,*/.DS_Store",
	wildmenu = true,
	wildmode = "longest:full,full",
	numberwidth = 3,
	wrap = true,
}

local windowOptions = {
	number = true,
	signcolumn = "yes",
}

for key, value in pairs(options) do
	vim.o[key] = value
end
for key, value in pairs(windowOptions) do
	vim.wo[key] = value
end

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
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
