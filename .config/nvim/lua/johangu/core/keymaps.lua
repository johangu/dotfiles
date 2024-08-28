-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<M-z>", "<cmd>setlocal wrap!<CR>", { silent = true })

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
end, { silent = true, desc = "[Q]uit current buffer" })
vim.keymap.set("n", "<leader>vn", "<cmd>vnew<CR>", { silent = true, desc = "[N]ew buffer in [V]ertical split" })
vim.keymap.set("n", "<leader>hn", "<cmd>split<CR>", { silent = true })
vim.keymap.set("n", "<space>", "za", { silent = true })
vim.keymap.set(
	"n",
	"<leader>cf",
	"<cmd>setlocal list! | setlocal wrap! | setlocal number! | setlocal relativenumber! | Gitsign toggle_signs<CR>",
	{ silent = true, desc = "Toggle [C]opy [F]riedly" }
)

-- use tab to indent in visual mode
vim.keymap.set("v", "<tab>", ">gv", { silent = true })
vim.keymap.set("v", "<s-tab>", "<gv", { silent = true })

-- Resize with arrow keys
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>", { silent = true })

-- Move text up and down
vim.keymap.set("n", "<A-j>", "<cmd>move .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>move .-2<CR>==", { silent = true })
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

vim.keymap.set("n", "<leader>z", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })

-- Jump around quickfix entries
vim.keymap.set("n", "[c", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "]c", "<cmd>cnext<CR>", { desc = "Next quickfix item" })

-- Open terminal splits
vim.keymap.set("n", "<leader>Tsv", ":vsp term://", { desc = "Open vertical terminal split" })
vim.keymap.set("n", "<leader>Tsh", ":sp term://", { desc = "Open horizontal terminal split" })
