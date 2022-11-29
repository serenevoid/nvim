local neogit = require('neogit')
local gitsigns = require('gitsigns')
local nnoremap = require('void.keymap').nnoremap

neogit.setup({
    disable_commit_confirmation = true,
    autorefresh = false,
})

gitsigns.setup({})

nnoremap("<leader>gs", ":lua require(\"neogit\").open({ kind = \"split\" })<CR>")
