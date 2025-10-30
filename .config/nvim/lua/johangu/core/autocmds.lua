local create_group = vim.api.nvim_create_augroup
local highlightYankGroup = create_group("UserYankConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlightYankGroup,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
	end,
})
