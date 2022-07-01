local augroup = vim.api.nvim_create_augroup
VoidGroup = augroup('Void', {})

require("void.packer")
require("void.set")
require("void.neogit")
require("void.color")
-- require("void.telescope")

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})
