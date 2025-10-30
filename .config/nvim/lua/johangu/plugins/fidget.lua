return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		integration = {
			["nvim-tree"] = { enable = true },
		},
		progress = {
			display = {
				progress_icon = {
					pattern = "arc",
					period = 1,
				},
			},
		},
		notification = {
			window = {
				winblend = 0,
			},
		},
	},
}
