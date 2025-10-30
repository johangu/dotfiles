return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			local telescope = require("telescope")
			-- telescope.load_extension('neoclip')
			local actions = require("telescope.actions")
			local previewers = require("telescope.previewers")
			local sorters = require("telescope.sorters")

			vim.keymap.set(
				"n",
				"<leader>?",
				require("telescope.builtin").oldfiles,
				{ desc = "Find recently opened files" }
			)
			vim.keymap.set(
				"n",
				"<leader><space>",
				require("telescope.builtin").buffers,
				{ desc = "Find existing buffers" }
			)
			vim.keymap.set(
				"n",
				"<leader>/",
				require("telescope.builtin").current_buffer_fuzzy_find,
				{ desc = "Fuzzy find in current buffer" }
			)
			vim.keymap.set("n", "<leader>sm", require("telescope.builtin").marks, { desc = "Search existing marks" })
			vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "Search Files" })
			vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "Search Help" })
			vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "Search Diagnostics" })
			vim.keymap.set("n", "<leader>zs", require("telescope.builtin").spell_suggest, { desc = "Suggest Spelling" })
			vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Search by Grep" })
			vim.keymap.set(
				"n",
				"<leader>sw",
				require("telescope.builtin").grep_string,
				{ desc = "Telescope: Search current word" }
			)
			vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search Git Files" })
			vim.keymap.set("n", "<leader>gc", require("telescope.builtin").git_commits, { desc = "Search Git Commits" })

			telescope.setup({
				defaults = {
					file_ignore_patterns = { "node_modules", "coverage", "lcov", ".git" },
					prompt_prefix = "   ",
					selection_caret = " ",
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_sorter = sorters.get_fuzzy_file,
					generic_sorter = sorters.get_generic_fuzzy_sorter,
					path_display = { "relative" },
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					use_less = true,
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					file_previewer = previewers.vim_buffer_cat.new,
					grep_previewer = previewers.vim_buffer_vimgrep.new,
					qflist_previewer = previewers.vim_buffer_qflist.new,
					-- Developer configurations: Not meant for general override
					buffer_previewer_maker = previewers.buffer_previewer_maker,
				},
				pickers = {
					marks = {
						sort_lastused = true,
						theme = "dropdown",
						winblend = 10,
					},
					current_buffer_fuzzy_find = {
						previewer = false,
						theme = "dropdown",
						winblend = 10,
					},
					buffers = {
						sort_lastused = true,
						theme = "dropdown",
						mappings = {
							n = { ["<c-d>"] = actions.delete_buffer },
							i = { ["<c-d>"] = actions.delete_buffer },
						},
					},
					spell_suggest = { theme = "cursor" },
					live_grep = {
						mappings = {
							n = { ["<c-e>"] = actions.to_fuzzy_refine },
							i = { ["<c-e>"] = actions.to_fuzzy_refine },
						},
					},
				},
			})
		end,
	},
}
