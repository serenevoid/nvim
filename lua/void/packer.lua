return require('packer').startup(function()
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Neogit
  use('TimUntersberger/neogit')

  -- Common Functions library
  use('nvim-lua/plenary.nvim')
end)
