local neogit = require('neogit')
local nnoremap = require('void.keymap').nnoremap

neogit.setup {}

nnoremap("<leader>gs", ":lua require(\"neogit\").open({ kind = \"split\" })<CR>")
