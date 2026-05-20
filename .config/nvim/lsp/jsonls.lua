---@type vim.lsp.Config
return {
	cmd = "jsonls",

	filetypes = { "json", "jsonc" },

	settings = {
		json = {
			format = {
				enable = false,
			},
			validate = {
				enable = true,
			},
			schemas = require("schemastore").json.schemas(),
		},
	},
}
