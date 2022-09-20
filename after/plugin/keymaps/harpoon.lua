local nnoremap = require("void.keymap").nnoremap

local silent = { silent = true }

nnoremap("<leader>ha", ":lua require(\"harpoon.mark\").add_file()<CR>", silent)
nnoremap("<leader>hh", ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>", silent)
nnoremap("<leader>ht", ":lua require(\"harpoon.cmd-ui\").toggle_quick_menu()<CR>", silent)

nnoremap("<leader>1", ":lua require(\"harpoon.ui\").nav_file(1)<CR>", silent)
nnoremap("<leader>2", ":lua require(\"harpoon.ui\").nav_file(2)<CR>", silent)
nnoremap("<leader>3", ":lua require(\"harpoon.ui\").nav_file(3)<CR>", silent)
nnoremap("<leader>4", ":lua require(\"harpoon.ui\").nav_file(4)<CR>", silent)
