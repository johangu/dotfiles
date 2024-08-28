local signs = {
	{ name = "Error", text = nil },
	{ name = "Info",  text = nil },
	{ name = "Warn",  text = nil },
	{ name = "Hint",  text = nil },
}
for _, sign in ipairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. sign.name, {
		text = sign.text,
		numhl = "Diagnostic" .. sign.name,
		linehl = "Diagnostic" .. sign.name,
	})
end

vim.diagnostic.config({
	underline = false,
	virtual_text = false,
	float = {
		border = 'rounded',
		focusable = false,
		update_in_insert = false,
		source = true,
	},
	signs = true,
	update_in_insert = true,
	severity_sort = true,
})


local diagnosticsGroup = vim.api.nvim_create_augroup('DiagnosticsExtras', {
	clear = true
})

vim.api.nvim_create_autocmd('CursorHold', {
	callback = function()
		vim.diagnostic.open_float()
	end,
	group = diagnosticsGroup
})
