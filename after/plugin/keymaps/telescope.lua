local Remap = require("void.keymap")
local nnoremap = Remap.nnoremap

-- Telescope keymaps
nnoremap("<C-p>", ":Telescope")
nnoremap("<leader>ps", ":lua require(\"telescope.builtin\").grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>")
nnoremap("<C-p>", ":lua require(\"telescope.builtin\").git_files()<CR>")
nnoremap("<Leader>pf", ":lua require(\"telescope.builtin\").find_files()<CR>")
nnoremap("<leader>pg", ":lua require(\"telescope.builtin\").grep_string { search = vim.fn.expand(\"<cword>\") }<CR>")
nnoremap("<leader>pb", ":lua require(\"telescope.builtin\").buffers()<CR>")
nnoremap("<leader>vh", ":lua require(\"telescope.builtin\").help_tags()<CR>")
