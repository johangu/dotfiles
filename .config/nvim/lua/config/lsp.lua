vim.lsp.enable('jsonls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')

local lspGroup = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lspGroup,
	callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client:supports_method('textDocument/completion') then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)
    end

		vim.keymap.set("n", "grh", vim.lsp.inlay_hint.enable, { buffer = bufnr, desc = "vim.lsp.inlay_hint.enable()" })
		vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "vim.lsp.buf.declaration()" })
		vim.keymap.set(
			"n",
			"grwa",
			vim.lsp.buf.add_workspace_folder,
			{ buffer = bufnr, desc = "vim.lsp.buf.add_workspace_folder()" }
		)
		vim.keymap.set(
			"n",
			"grwx",
			vim.lsp.buf.remove_workspace_folder,
			{ buffer = bufnr, desc = "vim.lsp.buf.remove_workspace_folder()" }
		)
		vim.keymap.set("n", "grwl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = bufnr, desc = "Workspace List Folders" })
	end,
})
