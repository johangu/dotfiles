return {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			completeUnimported = true,
			-- staticcheck = true,
			-- gofumpt = true,
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			usePlaceholders = true,
		},
	},
}
