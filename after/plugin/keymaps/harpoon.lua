local nnoremap = require("void.keymap").nnoremap

local silent = { silent = true }

nnoremap("<leader>a", ":lua require(\"harpoon.mark\").add_file()<CR>", silent)
nnoremap("<C-e>", ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>", silent)
nnoremap("<leader>tc", ":lua require(\"harpoon.cmd-ui\").toggle_quick_menu()<CR>", silent)

nnoremap("<C-h>", ":lua require(\"harpoon.ui\").nav_file(1)<CR>", silent)
nnoremap("<C-t>", ":lua require(\"harpoon.ui\").nav_file(2)<CR>", silent)
nnoremap("<C-n>", ":lua require(\"harpoon.ui\").nav_file(3)<CR>", silent)
nnoremap("<C-s>", ":lua require(\"harpoon.ui\").nav_file(4)<CR>", silent)
