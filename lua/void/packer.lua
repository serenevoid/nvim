return require('packer').startup(function()
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Neogit
  use('TimUntersberger/neogit')

  -- Undotree
  use('jiaoshijie/undotree')

  -- Common Functions library
  use('nvim-lua/plenary.nvim')

  -- Telescope
  use('nvim-telescope/telescope.nvim')

  -- Treesitter
  use('nvim-treesitter/nvim-treesitter', {
	  run = ':TSUpdate'
  })
  use('nvim-treesitter/nvim-treesitter-context')

  -- Harpoon
  use('ThePrimeagen/harpoon')

  -- Colorscheme
  use('folke/tokyonight.nvim')
  use('gruvbox-community/gruvbox')
end)
