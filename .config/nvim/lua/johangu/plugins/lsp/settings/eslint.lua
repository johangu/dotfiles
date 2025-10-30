-- local homeDir = vim.fn.expand("$HOME")
-- local nodeVersion = vim.fn.trim(vim.fn.system("node --version")):gsub("^v", "")
-- local nodePath = homeDir .. "/.local/share/asdf/installs/nodejs/" .. nodeVersion .. "/lib/node_modules"
return {
	settings = {
		format = {
			enable = false,
		},
		-- nodePath = nodePath,
	},
	-- libs = { nodePath },
}
