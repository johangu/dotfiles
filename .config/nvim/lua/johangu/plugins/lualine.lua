return {
	"hoob3rt/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"AndreM222/copilot-lualine",
	},
	config = function()
		local palette = require("catppuccin.palettes").get_palette()
		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = "", warn = "", info = "" },
		}

		local diff = {
			"diff",
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
		}

		local branch = { "branch", icon = "" }

		local mode = {
			function()
				return ""
			end,
			padding = { left = 1, right = 1 },
		}

		local pos_icon = {
			function()
				return ""
			end,
			color = {
				bg = palette.green,
				fg = palette.base,
			},
			padding = { left = 0, right = 1 },
		}

		local dir_icon = {
			function()
				return ""
			end,
			color = {
				bg = palette.pink,
				fg = palette.base,
			},
			separator = { left = "", right = "" },
			padding = { left = 0, right = 1 },
		}

		require("lualine").setup({
			options = {
				component_separators = "",
				icons_enabled = true,
				globalstatus = true,
				section_separators = { right = "", left = "" },
				theme = "catppuccin",
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { branch, diff },
				lualine_c = {
					{
						"filetype",
						colored = true,
						icon_only = true,
						padding = { left = 1, right = 0 },
					},
					{ "filename", file_status = true, full_path = true },
					diagnostics,
				},
				lualine_x = {
					dir_icon,
					{
						"vim.fn.fnamemodify(vim.fn.getcwd(), ':t')",
						color = {
							bg = palette.surface0,
							fg = palette.text,
						},
					},
				},
				lualine_y = {},
				lualine_z = {
					pos_icon,
					{
						"progress",
						color = {
							bg = palette.surface0,
							fg = palette.green,
						},
						separator = { left = "", right = "" },
						padding = { left = 1, right = 0 },
					},
					{
						"location",
						color = {
							bg = palette.surface0,
							fg = palette.green,
						},
						separator = { left = "", right = "" },
						padding = { left = 0, right = 0 },
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filetype", "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
