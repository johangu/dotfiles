return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			css = { "stylelint" },
			javascript = { "eslint" },
			python = { "mypy", "ruff" },
			terraform = { "tfsec" },
		}

		vim.keymap.set("n", "<leader>lf", require("lint").try_lint, { desc = "[L]int [F]ile" })

		local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePre" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
