local icons = {
	Copilot = "",
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		{
			"L3MON4D3/LuaSnip",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = { vim.fn.expand("./snippets") },
				})
			end,
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
	},
	opts = function(_, opts)
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- disable completion in comments
		opts.enabled = function()
			local context = require("cmp.config.context")
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("comment")
		end

		local select_or_jump = function(arg)
			local select_item_fn = function(dir)
				return dir > 0 and cmp.select_next_item or cmp.select_prev_item
			end

			return function(fallback)
				if cmp.visible() then
					return select_item_fn(arg)()
				end

				if luasnip.jumpable() then
					return luasnip.jump(arg)
				end

				fallback()
			end
		end

		opts.snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		}

		opts.mapping = cmp.mapping.preset.insert({
			["<C-n>"] = cmp.mapping(select_or_jump(1), { "c", "i", "s" }),
			["<C-p>"] = cmp.mapping(select_or_jump(-1), { "c", "i", "s" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
		})

		opts.formatting = {
			expandable_indicator = false,
			fields = { "abbr", "kind", "menu" },
			format = function(entry, item)
				item.kind = string.format("%s %s", icons[item.kind], item.kind)
				item.menu = ({
					copilot = "",
					buffer = "﬘",
					calc = "󰃬",
					luasnip = "",
					nvim_lsp = "ﲳ",
					nvim_lua = "",
					path = "",
				})[entry.source.name]
				return item
			end,
		}

		opts.sources = {
			{ name = "copilot" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "nvim_lua" },
			{ name = "calc" },
			{
				{ name = "buffer", keyword_length = 5 },
			},
		}

		opts.window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		}

		opts.view = {
			entries = "native",
		}

		opts.experimental = {
			ghost_text = true,
		}
	end,
}
