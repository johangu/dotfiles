local create_group = vim.api.nvim_create_augroup
local highlightYankGroup = create_group("UserYankConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlightYankGroup,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
	end,
})

local qolGroup = create_group("UserQoLGroup", { clear = true })

-- remember last cursor position in file
vim.api.nvim_create_autocmd("BufReadPost", {
	group = qolGroup,
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)

		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)

			-- defer centering to apply after rendering
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- resize splits evenly on terminal resize
vim.api.nvim_create_autocmd("VimResized", {
	group = qolGroup,
	command = "wincmd =",
})

-- use gd to navigate in help
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	group = qolGroup,
	callback = function()
		vim.keymap.set("n", "gd", "<C-]>", { buffer = true, silent = true })
	end,
})
