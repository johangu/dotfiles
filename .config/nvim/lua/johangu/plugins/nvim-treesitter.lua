return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				auto_install = false,
				ensure_installed = {
					"bash",
					"c",
					"c_sharp",
					"cpp",
					"css",
					"csv",
					"dockerfile",
					"git_rebase",
					"git_config",
					"gitcommit",
					"gitignore",
					"gitattributes",
					"go",
					"gomod",
					"gotmpl",
					"graphql",
					"html",
					"htmldjango",
					"http",
					"java",
					"jsdoc",
					"json",
					"jq",
					"lua",
					"luadoc",
					"php",
					"phpdoc",
					"python",
					"ruby",
					"rust",
					"tsx",
					"typescript",
					"javascript",
					"vimdoc",
					"vim",
					"vue",
					"xml",
				},

				highlight = { enable = true },
				indent = { enable = true, disable = { "yaml", "python" } },
				refactor = { highlight_definitions = { enable = true } },
				disable = function(_, bufnr)
					return vim.api.nvim_buf_line_count(bufnr) > 5000
				end,
			})
		end,
	},
}
