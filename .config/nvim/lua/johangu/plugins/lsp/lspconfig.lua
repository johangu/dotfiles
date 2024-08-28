return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
			config = true,
			automatic_installation = true,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "williamboman/mason.nvim" },
			opts = {
				ensure_installed = {
					"eslint",
					"tsserver",
					"cssls",
					"emmet_language_server",
					"gopls",
					"templ",
					"pylsp",
					"ruff",
					"lua_ls",
				},
			},
			config = function(_, opts)
				require("mason-lspconfig").setup(opts)
				local pylsp = require("mason-registry").get_package("python-lsp-server")

				pylsp:on("install:success", function()
					local function mason_package_path(package)
						local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
						return path
					end

					local path = mason_package_path("python-lsp-server")
					local command = path .. "/venv/bin/pip"
					local plugins = { "python-lsp-black", "python-lsp-ruff", "pylsp-mypy" }
					for _, plugin in pairs(plugins) do
						local args = {
							"install",
							"-U",
							plugin,
						}

						vim.schedule(function()
							require("plenary.job")
								:new({
									command = command,
									args = args,
									cwd = path,
								})
								:start()
							vim.notify(
								"[mason-lspconfig.nvim:user] " .. plugin .. " installed",
								vim.log.levels.INFO,
								{ title = "Mason.nvim" }
							)
						end)
					end
				end)
			end,
		},
		{
			"j-hui/fidget.nvim",
			opts = {
				integration = {
					["nvim-tree"] = { enable = true },
				},
				progress = {
					display = {
						progress_icon = {
							pattern = "arc",
							period = 1,
						},
					},
				},
				notification = {
					window = {
						winblend = 0,
					},
				},
			},
		},
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
					{ path = "LazyVim", words = { "LazyVim" } },
					"neotest",
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

			nmap("<leader>lh", vim.lsp.inlay_hint.enable, "[L]SP Inlay [H]ints")

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
