return {
	{
		'kyazdani42/nvim-web-devicons',
		lazy = true
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").load()
		end
	}
}
