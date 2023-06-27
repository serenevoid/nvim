return require('packer').startup(function(use)

    -- packer can manage itself
    use('wbthomason/packer.nvim')

    -- Common Functions library
    use('nvim-lua/plenary.nvim')
    use('nvim-lua/popup.nvim')

    -- Git
    use('lewis6991/gitsigns.nvim')

    -- LSP stuff
    use({
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {                                      -- Optional
          'williamboman/mason.nvim',
          run = function()
            pcall(vim.cmd, 'MasonUpdate')
          end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
        {'j-hui/fidget.nvim'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-nvim-lua'},
        {'saadparwaiz1/cmp_luasnip'}
      }
    })

    -- Helpers
    use('numToStr/Comment.nvim')
    use('m4xshen/autoclose.nvim')

    -- Telescope
    use('nvim-telescope/telescope.nvim')

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    -- Harpoon
    use('ThePrimeagen/harpoon')

    -- Colorscheme
    use('folke/tokyonight.nvim')
    use('kyazdani42/nvim-web-devicons')

end)
