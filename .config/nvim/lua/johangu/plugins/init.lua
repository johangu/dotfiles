return {
	{
		"turbio/bracey.vim",
		event = "VeryLazy",
		ft = { "html" },
		build = { "npm install --prefix server" },
	},
	"tpope/vim-sleuth",
	"tpope/vim-speeddating",
	"jiangmiao/auto-pairs",
	{
		"b0o/schemastore.nvim",
		ft = { "json" },
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {},
	},
}
