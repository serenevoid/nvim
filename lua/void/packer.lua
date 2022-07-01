return require('packer').startup(function()
    -- packer can manage itself
    use('wbthomason/packer.nvim')

    -- Neogit
    use('TimUntersberger/neogit')

    -- Undotree
    use('jiaoshijie/undotree')

    -- Common Functions library
    use('nvim-lua/plenary.nvim')
    use("nvim-lua/popup.nvim")

    -- LSP stuff
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use("onsails/lspkind-nvim")
    use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

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
