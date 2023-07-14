local Remap = require("void.keymap")
local nnoremap = Remap.nnoremap

-- Telescope keymaps
nnoremap("<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<CR>")
nnoremap("<leader>wd", ":lua require(\"kiwi\").open_diary_index()<CR>")
