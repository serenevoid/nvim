return {
	{
		'kyazdani42/nvim-web-devicons',
		lazy = true
	},
	{ 
		"folke/tokyonight.nvim", 
		priority = 1000,
		config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
		lazy = true
	}
}
