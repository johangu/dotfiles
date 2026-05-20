vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter.git",
		name = "nvim-treesitter",
		version = "main",
	},
})

local parsers = {
	"bash",
	"c",
	"cpp",
	"css",
	"csv",
	"dockerfile",
	"git_rebase",
	"git_config",
	"gitcommit",
	"gitignore",
	"gitattributes",
	"go",
	"gomod",
	"gotmpl",
	"graphql",
	"html",
	"htmldjango",
	"http",
	"jsdoc",
	"json",
	"jq",
	"lua",
	"luadoc",
	"markdown",
	"php",
	"phpdoc",
	"python",
	"ruby",
	"tsx",
	"typescript",
	"javascript",
	"vimdoc",
	"vim",
	"vue",
	"yaml",
	"xml",
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed", { clear = true }),
	callback = function(event)
		if event.data.kind == "update" then
			vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)
			---@diagnostic disable-next-line: param-type-mismatch
			local ok = pcall(vim.cmd, "TSUpdate")
			if ok then
				vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
			else
				vim.notify("TSUpdate command not available yet!", vim.log.levels.WARN)
			end
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = parsers,
	callback = function()
		vim.treesitter.start()
	end,
})
