local nnoremap = require("void.keymap").nnoremap
local kiwi = require('kiwi')
-- Necessary keybindings
nnoremap('<leader>ww', kiwi.open_wiki_index)
nnoremap('<leader>wd', kiwi.open_diary_index)
nnoremap('<leader>wn', kiwi.open_diary_new)
nnoremap('<leader-x>', kiwi.todo.toggle)
