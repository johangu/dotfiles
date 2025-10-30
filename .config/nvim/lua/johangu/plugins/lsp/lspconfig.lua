return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
					ensure_installed = {
						"eslint",
						"tsserver",
						"cssls",
						"emmet_language_server",
						"gopls",
						"templ",
						"pyright",
						"ruff",
						"lua_ls",
					},
				},
			},
		},
		lazy = true,
		cmd = "Mason",
		config = true,
		automatic_installation = true,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
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
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local on_init = function(client)
				if client.config.flags then
					client.config.flags.allow_incremental_sync = true
				end
			end

			mason_lspconfig.setup({})
			mason_lspconfig.setup_handlers({
				function(server_name)
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

					local opts = {
						capabilities = capabilities,
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
	},
}
