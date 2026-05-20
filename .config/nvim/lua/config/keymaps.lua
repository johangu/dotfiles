local utils = require("utils")

vim.keymap.set("n", "<leader>k", ":Explore<CR>", { silent = true })

vim.keymap.set("n", "<leader>l?", utils.inspect_lsp_client, { silent = true, desc = "Inspect LSP client" })

-- Remap for dealing with word wrap
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set({ "n", "x" }, "<M-z>", "<cmd>setlocal wrap!<CR>", { silent = true })

vim.keymap.set("n", "<tab>", "<cmd>bnext<CR>", { silent = true })
vim.keymap.set("n", "<s-tab>", "<cmd>bprevious<CR>", { silent = true })
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
end, { silent = true, desc = "Delete current buffer" })

vim.keymap.set("n", "<space>", "za", { silent = true })

-- Toggles
vim.keymap.set(
	"n",
	"<leader>'cf",
	"<cmd>IBLToggle | setlocal list! | setlocal wrap! | setlocal number! | setlocal relativenumber! | Gitsign toggle_signs<CR>",
	{ silent = true, desc = "Toggle copy friedly" }
)

-- use tab to indent in visual mode
vim.keymap.set("v", "<tab>", ">gv", { silent = true })
vim.keymap.set("v", "<s-tab>", "<gv", { silent = true })

-- Resize with arrow keys
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize +2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Move text up and down
vim.keymap.set("n", "<A-j>", "<cmd>move .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>move .-2<CR>==", { silent = true })
vim.keymap.set("i", "<A-j>", "<esc><cmd>move '>+1<CR>gi=gi", { silent = true })
vim.keymap.set("i", "<A-k>", "<esc><cmd>move '<-2<CR>gi=gi", { silent = true })
vim.keymap.set({ "v", "x" }, "<A-j>", ":move '>+1<CR>gv=gv", { silent = true })
vim.keymap.set({ "v", "x" }, "<A-k>", ":move '<-2<CR>gv=gv", { silent = true })

-- The great remaps
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without replacing register" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to host clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank to host clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to host clipboard" })

-- Better line join
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle when moving around
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>z", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })

-- Jump around quickfix entries
vim.keymap.set("n", "[c", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "]c", "<cmd>cnext<CR>", { desc = "Next quickfix item" })

-- Open terminal splits
vim.keymap.set("n", "<leader>Tsv", ":vsp term://", { desc = "Open vertical terminal split" })
vim.keymap.set("n", "<leader>Tsh", ":sp term://", { desc = "Open horizontal terminal split" })

-- yank/delete to clipboard
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d<CR>')
