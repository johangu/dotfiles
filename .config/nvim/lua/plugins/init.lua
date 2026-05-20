vim.pack.add({
	{
		src = "https://github.com/b0o/schemastore.nvim",
		name = "schemastore",
	},
	{
		src = "https://github.com/tpope/vim-speeddating",
		name = "speeddating",
	},
})

require("plugins.catppuccin")
require("plugins.copilot")
require("plugins.conform")
require("plugins.fidget")
require("plugins.git")
require("plugins.headlines")
require("plugins.lualine")
require("plugins.md-render")
require("plugins.nvim-web-devicons")
require("plugins.nvim-lint")
require("plugins.nvim-treesitter")
require("plugins.nvim-surround")
require("plugins.which_key")
