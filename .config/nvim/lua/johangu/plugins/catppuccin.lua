return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			custom_highlights = function(colors)
				return { BiscuitColor = { fg = colors.overlay0 } }
			end,
			integrations = {
				cmp = true,
				dap = true,
				dap_ui = true,
				fidget = true,
				gitsigns = true,
				headlines = true,
				indent_blankline = {
					colored_indent_levels = true,
					enabled = true,
				},
				mason = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				neotest = true,
				nvimtree = true,
				telescope = {
					enabled = true,
				},
				treesitter = true,
				ts_rainbow = true,
				which_key = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
