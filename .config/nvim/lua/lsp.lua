local lspGroup = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lspGroup,
	callback = function()
		local nmap = function(keys, func, desc)
			if desc then
				desc = "LSP: " .. desc
			end

			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
		end

		nmap("<leader>lh", vim.lsp.inlay_hint.enable, "Inlay Hints")

		nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")

		nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
		nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
		nmap("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "Workspace List Folders")
	end,
})
