return({
	-- Treesitter
	'nvim-treesitter/nvim-treesitter',
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" }
})
