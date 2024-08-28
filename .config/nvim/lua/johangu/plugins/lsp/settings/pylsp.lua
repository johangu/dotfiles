return {
	pylsp = {
		plugins = {
			ruff = {
				enabled = true,
				formatEnabled = true,
			},
			black = { enabled = true },
			pylsp_mypy = { enabled = true, live_mode = true },
		},
	},
}
