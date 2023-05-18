local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth',
  'tpope/vim-speeddating',
  -- 'tpope/vim-surround',
  'jiangmiao/auto-pairs',
  'b3nj5m1n/kommentary',
  'b0o/schemastore.nvim',
  {
    'kylechui/nvim-surround',
    event = "VeryLazy",
    config = true
  },

  -- LSP Config and plugins
  require 'plugins.lspconfig',

  { -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip'
      },
      config = function() require 'plugins.cmp' end
    }
  },

  require 'plugins.catppuccin',
  -- require 'plugins.tokyonight',
  require 'plugins.lualine',
  require 'plugins.colorizer',
  require 'plugins.indent_blankline',
  require 'plugins.which_key',
  require 'plugins.tree',
  require 'plugins.gitsigns',

  {
    'nvim-telescope/telescope.nvim',
    config = function() require 'plugins.telescope' end,
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function() return vim.fn.executable 'make' == 1 end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function() require 'plugins.treesitter' end,
    dependencies = {
      'p00f/nvim-ts-rainbow',
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    build = ':TSUpdate'
  },

  --[[ {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true
  } ]]

}, {})

--[[ use {
    'lewis6991/impatient.nvim',
    config = function() require 'plugins.impatient' end
  } ]]
-- use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }
--[[ use {
    'tpope/vim-projectionist',
    config = function() require 'plugins.projectionist' end
  }
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use {
    'godlygeek/tabular',
    config = function() require 'plugins.tabularize' end
  } ]]
--[[ use {
    'AckslD/nvim-neoclip.lua',
    requires = 'nvim-telescope/telescope.nvim',
    config = function() require'neoclip'.setup {} end
  } ]]
-- use { 'mfussenegger/nvim-dap', config = function() require'plugins.dap' end }
-- use { 'NTBBloodbath/rest.nvim', ft = {'http'}, config = function() require'plugins.rest' end }

--[[ use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-calc'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline' ]]
-- snippets
-- use 'rafamadriz/friendly-snippets'

-- Languages
-- use { 'plasticboy/vim-markdown', ft = 'markdown' }
