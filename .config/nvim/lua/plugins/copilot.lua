vim.pack.add({
	{
		src = "https://github.com/zbirenbaum/copilot.lua",
		name = "copilot",
	},
})

require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = false,
	},
	-- panel = { enabled = false },
	filetypes = {
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	copilot_node_command = "node", -- Node.js version must be > 16.x
	server_opts_overrides = {},
	-- on_status_update = require("lualine").refresh,
})
