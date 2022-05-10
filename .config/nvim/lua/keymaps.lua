local keymap = require'utils'.map

keymap('n', '<tab>', ':bnext<CR>')
keymap('n', '<s-tab>', ':bprevious<CR>')
keymap('n', '<leader>q', ':bp<bar>sp<bar>bn<bar>bd<CR>')
keymap('n', '<leader>vn', ':vnew<CR>')
keymap('n', '<leader>hn', ':split<CR>')
keymap('n', '<leader>l', ':set list<CR>')
keymap('n', '<space>', 'za')

-- use tab to indent in visual mode
keymap('v', '<tab>', '>gv')
keymap('v', '<s-tab>', '<gv')

-- format file
keymap('n', 'gp', ':lua require"utils".preserve("normal gggqG")<CR>')

-- fix indentation
keymap('n', '_=', ':lua require"utils".preserve("normal gg=G")<CR>')

-- Resize with arrow keys
keymap('n', '<C-Up>', ':resize -2<CR>')
keymap('n', '<C-Down>', ':resize +2<CR>')
keymap('n', '<C-Left>', ':vertical resize -2<CR>')
keymap('n', '<C-Right>', ':vertical resize +2<CR>')

-- Move text up and down
keymap('n', '<A-j>', '<Esc>:move .+1<CR>==')
keymap('n', '<A-k>', '<Esc>:move .-2<CR>==')
keymap("v", "<A-j>", ":move .+1<CR>==")
keymap("v", "<A-k>", ":move .-2<CR>==")
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- normalise leaving terminal insert mode
keymap("t", "<C-[>", "<C-\\><C-n>")
