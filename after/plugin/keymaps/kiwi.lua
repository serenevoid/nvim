local Remap = require("void.keymap")
local nnoremap = Remap.nnoremap
local kiwi = require("kiwi")

nnoremap("<leader>ww", kiwi.open_wiki_index)
nnoremap("<leader>wd", kiwi.open_diary_index)
nnoremap("<leader>wn", kiwi.open_diary_new)
