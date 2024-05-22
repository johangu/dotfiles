-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<M-z>", ":setlocal wrap!<CR>", { silent = true })

vim.keymap.set("n", "<tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<s-tab>", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", function()
	local count = 0
	for i = 1, vim.fn.bufnr("$"), 1 do
		if vim.fn.buflisted(i) then
			count = count + 1
		end
	end
	if count > 1 then
		count = 0
		vim.cmd("bp|sp|bn|bd")
	else
		vim.cmd("quit")
	end
end, { silent = true, desc = "[Q]uit current buffer" })
vim.keymap.set("n", "<leader>vn", ":vnew<CR>", { silent = true, desc = "[N]ew buffer in [V]ertical split" })
vim.keymap.set("n", "<leader>hn", ":split<CR>", { silent = true })
vim.keymap.set("n", "<leader>l", ":setlocal list!<CR>", { silent = true })
vim.keymap.set("n", "<space>", "za", { silent = true })

-- use tab to indent in visual mode
vim.keymap.set("v", "<tab>", ">gv", { silent = true })
vim.keymap.set("v", "<s-tab>", "<gv", { silent = true })

-- Resize with arrow keys
vim.keymap.set("n", "<C-S-Up>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Down>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Right>", ":vertical resize +2<CR>", { silent = true })

-- Move text up and down
vim.keymap.set("n", "<A-j>", ":move .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":move .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv=gv", { silent = true })

-- normalise leaving terminal insert mode
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { silent = true })

-- The great remaps
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "[P]aste without replacing register" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "[Y]ank to host clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "[Y]ank to host clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[Y]ank to host clipboard" })

-- Better line join
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle when moving around
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>[", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>]", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
