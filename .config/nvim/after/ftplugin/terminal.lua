vim.opt_local.buflisted = false
vim.opt_local.modified = false
vim.opt_local.number = false
vim.opt_local.signcolumn = "no"

-- normalise leaving terminal insert mode
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { silent = true })
