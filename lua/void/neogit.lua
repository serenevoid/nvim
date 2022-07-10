local neogit = require('neogit')
local nnoremap = require('void.keymap').nnoremap

neogit.setup({
    disable_commit_confirmation = true,
    autorefresh = false,
})

nnoremap("<leader>gs", ":lua require(\"neogit\").open({ kind = \"split\" })<CR>")
