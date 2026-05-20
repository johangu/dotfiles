vim.pack.add({
	{
		src = "https://github.com/delphinus/md-render.nvim",
		name = "md-render",
		data = {
			event = "FileReadPre",
			ft = "markdown",
		},
	},
}, {
	load = false,
})
