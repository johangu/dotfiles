vim.pack.add({
	"https://github.com/NeogitOrg/neogit.git",
	"https://github.com/sindrets/diffview.nvim.git",
	"https://github.com/lewis6991/gitsigns.nvim.git",
})

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
		nmap("]h", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				require("gitsigns").next_hunk()
			end)
			return "<Ignore>"
		end, "Go to Next hunk", true)
		nmap("[h", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				require("gitsigns").previous_hunk()
			end)
			return "<Ignore>"
		end, "Go to Previous hunk", true)

		-- Actions
		vmap("<leader>gss", function()
			require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage hunk")
		vmap("<leader>gsr", function()
			require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset hunk")
		nmap("<leader>gss", require("gitsigns").stage_hunk, "Stage hunk")
		nmap("<leader>gsr", require("gitsigns").reset_hunk, "Reset hunk")
		nmap("<leader>gsS", require("gitsigns").stage_buffer, "Stage buffer")
		nmap("<leader>gsu", require("gitsigns").undo_stage_hunk, "Undo stage hunk")
		nmap("<leader>gsR", require("gitsigns").reset_buffer, "Reset buffer")
		nmap("<leader>gsp", require("gitsigns").preview_hunk, "Preview hunk")
		nmap("<leader>gsd", require("gitsigns").diffthis, "Diff")
		nmap("<leader>gsq", require("gitsigns").setqflist, "Send Hunks to Quickfix")
		nmap("<leader>tb", require("gitsigns").toggle_current_line_blame, "Toggle Blame on current line")
		nmap("<leader>td", require("gitsigns").toggle_deleted, "Toggle Deleted")
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
