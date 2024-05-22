local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

return {
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
		diagnostics = {
			enabled = true,
			ignoredCodes = {
				80001, -- File is a CommonJS module; it may be converted to an ES module.
				80005,
			},
		},
		javascript = {
			showUnused = false,
			suggestionActions = {
				enabled = true,
			},
		},
	},
	commands = {
		OrganizeImports = { organize_imports, description = "Organize Imports" },
	},
}
