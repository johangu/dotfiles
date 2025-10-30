return {
	"Saghen/blink.cmp",
	event = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		completion = {
			documentation = { auto_show = true },
			list = {
				selection = {
					preselect = false,
				},
			},
			menu = { auto_show = false },
		},
		sources = {
			-- `lsp`, `buffer`, `snippets`, `path` and `omni` are built-in
			-- so you don't need to define them in `sources.providers`
			default = { "lsp", "buffer", "snippets", "path" },

			per_filetype = { sql = { "snippets", "buffer", "lsp" } },
		},
	},
}
