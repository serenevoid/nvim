return({
  'ThePrimeagen/harpoon',
  keys = {
    { "<leader>ha", ":lua require(\"harpoon.mark\").add_file()<cr>", desc = "Add file to harpoon" },
    { "<leader>hh", ":lua require(\"harpoon.ui\").toggle_quick_menu()<cr>", desc = "Launch harpoon" },
    { "<leader>t1", ":lua require(\"harpoon.term\").gotoTerminal(1)<cr>", desc = "Launch terminal 1" },
    { "<leader>t2", ":lua require(\"harpoon.term\").gotoTerminal(2)<cr>", desc = "Launch terminal 2" },
    { "<leader>t3", ":lua require(\"harpoon.term\").gotoTerminal(3)<cr>", desc = "Launch terminal 3" },
    { "<leader>t4", ":lua require(\"harpoon.term\").gotoTerminal(4)<cr>", desc = "Launch terminal 4" },
    { "<leader>hc", ":lua require(\"harpoon.cmd-ui\").toggle_quick_menu()<cr>", desc = "Launch command list" }
  }
})
