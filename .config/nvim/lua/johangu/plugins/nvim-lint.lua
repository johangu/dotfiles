return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			bash = { "shellcheck" },
			css = { "stylelint" },
			javascript = { "eslint" },
			python = { "mypy", "ruff" },
			terraform = { "tfsec" },
			php = { "phpcs", "phpmd", "phpstan" },
			java = { "checkstyle" },
		}

		local phpmd = lint.linters.phpmd
		local phpstan = lint.linters.phpstan

		phpmd.cmd = function()
			local bin = "phpmd"
			local local_bin = vim.fn.fnamemodify("tools/phpmd/vendor/bin/" .. bin, ":p")
			return vim.loop.fs_stat(local_bin) and local_bin or bin
		end
		phpmd.args = vim.list_extend({ "tools/phpmd/phpmd.xml" }, phpmd.args)

		phpstan.cmd = function()
			local bin = "phpstan"
			local local_bin = vim.fn.fnamemodify("tools/phpstan/vendor/bin/" .. bin, ":p")
			return vim.loop.fs_stat(local_bin) and local_bin or bin
		end
		phpstan.args = vim.list_extend({ "-l", "10" }, phpstan.args)

		vim.keymap.set("n", "<leader>lf", require("lint").try_lint, { desc = "[L]int [F]ile" })

		local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })

		vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePre" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
