return ({
	{
		dir = '$HOME/dev/projects/kiwi.nvim',
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		keys = {
			{ "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
			{ "<leader>wd", ":lua require(\"kiwi\").open_diary_index()<cr>", desc = "Open Diary index" },
			{ "<leader>wn", ":lua require(\"kiwi\").open_diary_new()<cr>", desc = "Open today's Diary" },
			{ "<leader>t", ":lua require(\"kiwi\").todo.toggle()<cr>", desc = "Toggle Markdown Task" }
		},
		lazy = true
	}
})
