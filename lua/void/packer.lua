return require('packer').startup(function()

    -- packer can manage itself
    use('wbthomason/packer.nvim')

    -- Neogit
    use('TimUntersberger/neogit')
    use('lewis6991/gitsigns.nvim')

    -- Common Functions library
    use('nvim-lua/plenary.nvim')
    use("nvim-lua/popup.nvim")

    -- LSP stuff
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-nvim-lua")
    use("onsails/lspkind-nvim")
    use("glepnir/lspsaga.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("windwp/nvim-autopairs")

    -- Telescope
    use('nvim-telescope/telescope.nvim')

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-context')

    -- Harpoon
    use('ThePrimeagen/harpoon')

    -- Colorscheme
    use('folke/tokyonight.nvim')
    use('gruvbox-community/gruvbox')
    use('kyazdani42/nvim-web-devicons')
end)
