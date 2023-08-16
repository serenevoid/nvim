return({
	'ThePrimeagen/harpoon',
	keys = {
			{ "<leader>ha", ":lua require(\"harpoon.mark\").add_file()<cr>", desc = "Add file to harpoon" },
			{ "<leader>hh", ":lua require(\"harpoon.ui\").toggle_quick_menu()<cr>", desc = "Launch harpoon " },
			{ "<leader>ht", ":lua require(\"harpoon.cmd-ui\").toggle_quick_menu()<cr>", desc = "Launch harpoon command" }
	}
})
