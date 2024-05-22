return {
	"nvim-treesitter/nvim-treesitter",
	tag = "v0.9.2",
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			autopairs = { enable = true },
			auto_install = false,
			ensure_installed = {
				"c",
				"cpp",
				"css",
				"go",
				"graphql",
				"html",
				"http",
				"json",
				"jq",
				"lua",
				"python",
				"ruby",
				"rust",
				"tsx",
				"typescript",
				"javascript",
				"vimdoc",
				"vim",
				"xml",
			},

			highlight = { enable = true },
			indent = { enable = true, disable = { "yaml", "python" } },
			refactor = { highlight_definitions = { enable = true } },
		})
	end,
}
