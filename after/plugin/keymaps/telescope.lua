local Remap = require("void.keymap")
local nnoremap = Remap.nnoremap

-- Telescope keymaps
nnoremap("<Leader>pf", ":lua require(\"telescope.builtin\").find_files()<CR>")
nnoremap("<Leader>pg", ":lua require(\"telescope.builtin\").git_files()<CR>")
nnoremap("<leader>ps", ":lua require(\"telescope.builtin\").grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>")
nnoremap("<leader>pb", ":lua require(\"telescope.builtin\").buffers()<CR>")
nnoremap("<leader>ph", ":lua require(\"telescope.builtin\").help_tags()<CR>")
