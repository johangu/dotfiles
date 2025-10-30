return {
	-- "tpope/vim-sleuth",
	{
		"tpope/vim-speeddating",
		keys = { "<C-a>", "<C-x>" },
	},
	{
		"b0o/schemastore.nvim",
		lazy = true,
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "dbui" },
		},
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
	},
	{
		"rafamadriz/friendly-snippets",
		lazy = true,
	},
}
