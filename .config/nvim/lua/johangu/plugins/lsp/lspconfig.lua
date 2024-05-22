return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			config = true,
			opts = {
				ensure_installed = {
					"eslint-lsp",
					"lua-language-server",
					"typescript-language-server",
					"python-lsp-server",
					"css-lsp",
					"emmet-language-server",
					"gopls",
				},
			},
			automatic_installation = true,
		},
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"j-hui/fidget.nvim",
			tag = "legacy",
			opts = {
				event = { "LspAttach" },
				text = { spinner = "dots" },
				window = {
					blend = 0,
				},
			},
		},
		{
			"folke/neodev.nvim",
			opts = {
				library = {
					plugins = {
						"neotest",
					},
					types = true,
				},
			}, -- make sure setup is run
		},
		"Issafalcon/lsp-overloads.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local overloads = require("lsp-overloads")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local on_init = function(client)
			if client.config.flags then
				client.config.flags.allow_incremental_sync = true
			end
		end

		local on_attach = function(client, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

			nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

			nmap("K", vim.lsp.buf.hover, "Hover Documentation")
			nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

			nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")

			if client.server_capabilities.signatureHelpProvider then
				overloads.setup(client, {})
			end
		end

		mason_lspconfig.setup({})
		mason_lspconfig.setup_handlers({
			function(server_name)
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

				local opts = {
					capabilities = capabilities,
					on_attach = on_attach,
					on_init = on_init,
				}

				local server_status_ok, server_opts = pcall(require, "johangu.plugins.lsp.settings." .. server_name)
				if server_status_ok then
					opts = vim.tbl_extend("force", server_opts, opts)
				end

				lspconfig[server_name].setup(opts)
			end,
		})
	end,
}
