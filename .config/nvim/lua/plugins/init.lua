local cmd = vim.cmd
local fn = vim.fn

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  }
end
cmd [[packadd packer.nvim]]

-- Auto compile when there are changes in plugins/init.lua
cmd [[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync 
  augroup end
 ]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify 'Error loading packer.nvim'
  return
end

packer.init {
  max_jobs = 6,
  git = { default_url_format = 'git@github.com:%s' },
  display = {
    open_fn = function()
      return require'packer.util'.float { border = 'rounded' }
    end
  }
}

return packer.startup(function(use)
  -- self manage
  use { 'wbthomason/packer.nvim', opt = true }
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    config = function() require 'plugins.telescope' end,
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' }
    }
  }

  -- UI/UX
  use 'folke/tokyonight.nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'hoob3rt/lualine.nvim',
    config = function() require 'plugins.lualine' end,
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require 'plugins.colorizer' end
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require 'plugins.indent_blankline' end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function() require 'plugins.tree' end,
    requires = 'nvim-web-devicons'
  }
  --[[ use {
    'lewis6991/impatient.nvim',
    config = function() require 'plugins.impatient' end
  } ]]

  -- Productivity
  use 'github/copilot.vim'
  use 'b0o/schemastore.nvim'
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }
  use 'b3nj5m1n/kommentary'
  use {
    'tpope/vim-projectionist',
    config = function() require 'plugins.projectionist' end
  }
  use 'tpope/vim-speeddating'
  use 'tpope/vim-surround'
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use {
    'godlygeek/tabular',
    config = function() require 'plugins.tabularize' end
  }
  -- use 'jiangmiao/auto-pairs'
  -- use { 'hrsh7th/nvim-compe', config = function() require 'plugins.compe' end }
  use {
    'AckslD/nvim-neoclip.lua',
    requires = 'nvim-telescope/telescope.nvim',
    config = function() require'neoclip'.setup {} end
  }
  use 'mfussenegger/nvim-dap'

  -- git
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require 'plugins.gitsigns' end,
    requires = 'nvim-lua/plenary.nvim'
  }

  use { 'hrsh7th/nvim-cmp', config = function() require 'plugins.cmp' end }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-calc'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions

  -- snippets
  use 'L3MON4D3/LuaSnip' -- snippet engine
  use 'rafamadriz/friendly-snippets'

  -- Languages
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use { 'plasticboy/vim-markdown', ft = 'markdown' }
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require 'plugins.treesitter' end,
    requires = { 'p00f/nvim-ts-rainbow' }, -- rainbow parens for treesitter
    run = ':TSUpdate'
  }

  -- flutter
  use {
    'akinsho/flutter-tools.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function() require'flutter-tools'.setup {} end,
    ft = 'dart'
  }

  -- lua
  use { 'rafcamlet/nvim-luapad', ft = 'lua' }

  -- Automatically set up the config after cloning packer.nvim
  if PACKER_BOOTSTRAP then packer.sync() end
end)
