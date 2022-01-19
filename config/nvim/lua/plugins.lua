return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'dracula/vim'

  use 'neovim/nvim-lspconfig'

  use { 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- telescope
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "nvim-telescope/telescope-file-browser.nvim" }


  use {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup()
    end,
  }

  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end,
  }

  use 'editorconfig/editorconfig-vim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  use "rafamadriz/friendly-snippets"

  use 'justinmk/vim-sneak'

  use 'norcalli/nvim-colorizer.lua'
end)
