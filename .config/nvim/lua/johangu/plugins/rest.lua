return {}
--[[ return {
	"rest-nvim/rest.nvim",
	dependencies = {
		{
			"vhyrro/luarocks.nvim",
			opts = {
				rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
			},
			priority = 1000,
			config = true,
		},
		"folke/which-key.nvim",
		optional = true,
		opts = {
			defaults = {
				["<leader>r"] = { name = "+rest" },
			},
		},
	},
	event = "VeryLazy",
	ft = "http",
	config = function()
		require("rest-nvim.functions")
		vim.keymap.set("n", "<leader>rr", function()
			require("rest-nvim.functions").exec("cursor")
		end, { desc = "[R]EST run under cursor", buffer = true })
		vim.keymap.set("n", "<leader>rl", function()
			require("rest-nvim.functions").exec("last")
		end, { desc = "[R]EST run last", buffer = true })
		require("rest-nvim").setup()
	end,
} ]]
