vim.pack.add({
	{
		src = "https://github.com/stevearc/conform.nvim.git",
		name = "conform",
	},
})

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		bash = { "shfmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		html = { "prettier" },
		go = { "gofumpt" },
		css = { "prettier", "stylelint" },
		scss = { "scss", "prettier", stop_after_first = true },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		htmldjango = { "djlint" },
		python = { "ruff", "autopep8", "black" },
		php = { "php_cs_fixer" }, --{ "pint" },
		sql = { "sql_formatter" },
		twig = { "prettier" },
	},

	formatters = {
		builtin = function()
			return vim.api.nvim_feedkeys("m6gg=G'6", "n", false)
		end,
		scss = {
			command = "stylelint",
		},
	},

	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

vim.keymap.set({ "n", "v" }, "gp", function()
	conform.format({
		lsp_fallback = true,
		async = false,
	})
end, { desc = "Format file or range (in visual mode)" })
