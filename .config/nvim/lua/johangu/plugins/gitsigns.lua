-- vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GitSignsAdd" })
-- vim.api.nvim_set_hl(0, "GitSignsAddLn", { link = "GitSignsAddLn" })
-- vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "GitSignsAddNr" })
-- vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GitSignsChange" })
-- vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "GitSignsChangeLn" })
-- vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "GitSignsChangeNr" })
-- vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "GitSignsChange" })
-- vim.api.nvim_set_hl(0, "GitSignsChangedeleteLn", { link = "GitSignsChangeLn" })
-- vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { link = "GitSignsChangeNr" })
-- vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "GitSignsDelete" })
-- vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "GitSignsDeleteLn" })
-- vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "GitSignsDeleteNr" })
-- vim.api.nvim_set_hl(0, "GitSignsTopdelete", { link = "GitSignsDelete" })
-- vim.api.nvim_set_hl(0, "GitSignsTopdeleteLn", { link = "GitSignsDeleteLn" })
-- vim.api.nvim_set_hl(0, "GitSignsTopdeleteNr", { link = "GitSignsDeleteNr" })

return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local nmap = function(keys, func, desc, expr)
					if desc then
						desc = "Gitsigns: " .. desc
					end

					vim.keymap.set("n", keys, func, { desc = desc, expr = expr or false, buffer = bufnr })
				end
				local vmap = function(keys, func, desc)
					if desc then
						desc = "Gitsigns: " .. desc
					end

					vim.keymap.set("n", keys, func, { desc = desc, buffer = bufnr })
				end
				-- Navigation
				nmap("<leader>gn", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						require("gitsigns").next_hunk()
					end)
					return "<Ignore>"
				end, "[G]o to [N]ext hunk", true)
				nmap("<leader>gp", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						require("gitsigns").previous_hunk()
					end)
					return "<Ignore>"
				end, "[G]o to [P]revious hunk", true)

				-- Actions
				vmap("<leader>hs", function()
					require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "[H]unk, [S]tage")
				vmap("<leader>hr", function()
					require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "[H]unk, [R]eset")
				nmap("<leader>hs", require("gitsigns").stage_hunk, "[H]unk, [S]tage")
				nmap("<leader>hr", require("gitsigns").reset_hunk, "[H]unk, [R]eset")
				nmap("<leader>hS", require("gitsigns").stage_buffer, "Stage buffer")
				nmap("<leader>hu", require("gitsigns").undo_stage_hunk, "[H]unk stage, [U]ndo")
				nmap("<leader>hR", require("gitsigns").reset_buffer, "Reset buffer")
				nmap("<leader>hp", require("gitsigns").preview_hunk, "[H]unk, [P]review")
				nmap("<leader>hd", require("gitsigns").diffthis, "Diff")
				nmap("<leader>hq", require("gitsigns").setqflist, "Send [H]unks to [Q]quickfix")
				nmap("<leader>tb", require("gitsigns").toggle_current_line_blame, "[T]oggle [B]lame on current line")
				nmap("<leader>td", require("gitsigns").toggle_deleted, "[T]oggle [D]eleted")
			end,
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			watch_gitdir = { interval = 1000 },
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 350,
				ignore_whitespace = true,
			},
			current_line_blame_formatter = "<author>, <author_time> - <summary>", -- :%R for relative time
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			attach_to_untracked = true,
			diff_opts = {
				internal = true, -- If luajit is present
			},
		})
	end,
}
