local nnoremap = require("void.keymap").nnoremap

local silent = { silent = true }

nnoremap("<leader>ha", ":lua require(\"harpoon.mark\").add_file()<CR>",            silent)
nnoremap("<leader>hh", ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>",     silent)
nnoremap("<leader>ht", ":lua require(\"harpoon.cmd-ui\").toggle_quick_menu()<CR>", silent)
