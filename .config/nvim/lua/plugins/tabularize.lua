local keymap = require'utils'.map

keymap("v", "<leader><leader>=", ":Tabularize /=<CR>")
keymap("v", "<leader><leader>|", ":Tabularize /|<CR>")
keymap("v", "<leader><leader>:", ":Tabularize /:<CR>")
keymap("n", "<leader><leader>=", ":Tabularize /=<CR>")
keymap("n", "<leader><leader>|", ":Tabularize /|<CR>")
keymap("n", "<leader><leader>:", ":Tabularize /:<CR>")
