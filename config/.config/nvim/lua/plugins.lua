local status, packer = pcall(require, 'packer')
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use 'kyazdani42/nvim-web-devicons'
  use 'L3MON4D3/LuaSnip'         -- snippet
  use {
    'nvim-lualine/lualine.nvim', -- statusline
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'onsails/lspkind-nvim'  -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer'    -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'  -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp'      -- Completion
  use 'neovim/nvim-lspconfig' -- LSP
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'norcalli/nvim-colorizer.lua'
  use 'lewis6991/gitsigns.nvim'

  use 'Shougo/context_filetype.vim'
  use 'osyo-manga/vim-precious'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  use {
    'github/copilot.vim',
    run = ':Copilot setup'
  }
end)
