return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim'
	},
	keys = {
			{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>pg", "<cmd>Telescope git_files<cr>", desc = "Find git tracked files" },
			{ "<leader>pb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },
			{ "<leader>ph", "<cmd>Telescope help_tags<cr>", desc = "Search Help Tags" },
			{ "<leader>ps", "<cmd>Telescope grep_string<cr>", desc = "Grep String" }
	},
	lazy = true
}
