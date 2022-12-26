local ls = require('luasnip')

local inoremap = require("void.keymap").inoremap
local snoremap = require("void.keymap").snoremap
local opts = { noremap = true, silent = true }

local expand_or_jump = function()
    print("Hello")
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end

local jump_back = function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end

local next_choice = function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end

inoremap("<c-j>", expand_or_jump, opts)
snoremap("<c-j>", expand_or_jump, opts)
inoremap("<c-k>", jump_back, opts)
snoremap("<c-k>", jump_back, opts)
inoremap("<c-l>", next_choice, opts)
