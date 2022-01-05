local map = vim.api.nvim_set_keymap

vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.formatprg = 'dart format -l 100 -o show --fix'

vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
vim.cmd("command! LspRangeCodeAction lua vim.lsp.buf.range_code_action()")
vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
vim.cmd(
    "command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev({ wrap = false, popup_opts = { border = 'single', focusable = false }})")
vim.cmd(
    "command! LspDiagNext lua vim.lsp.diagnostic.goto_next({ wrap = false, popup_opts = { border = 'single', focusable = false }})")
vim.cmd(
    "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = true, border = 'single', focusable = false })")
vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
local opts = {noremap = true, silent = true}
map("n", "<leader>fc", "<cmd>Telescope flutter commands<cr>", opts)
map("n", "K", ":LspHover<CR>", opts)
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", ":LspDef<CR>", opts)
map("n", "gy", ":LspTypeDef<CR>", opts)
map("n", "gR", ":LspRename<CR>", opts)
map("n", "gr", ":LspRefs<CR>", opts)
map("n", "K", ":LspHover<CR>", opts)
map("n", "gi", ":LspImplementation<CR>", opts)
map("n", "<C-k>", ":LspSignatureHelp<CR>", opts)
map("n", "[d", ":LspDiagNext<CR>", opts)
map("n", "]d", ":LspDiagPrev<CR>", opts)
map("n", "<leader>[", ":LspDiagLine<CR>", opts)
map("n", "<leader>ca", ":LspCodeAction<CR>", opts)
map("x", "<leader>ca", ":LspRangeCodeAction<CR>", opts)

map("n", "<leader>law", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
map("n", "<leader>lrw", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts)
map("n", "<leader>llw",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts)
map("n", "<leader>ll", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
-- require("telescope").load_extension("flutter")
