local M = {}

function M.nnoremap(lhs, rhs)
	vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true })
end

local nnoremap = M.nnoremap

nnoremap("<leader>pv", ":Ex<CR>")
nnoremap("<leader>u", ":UndotreeToggle<CR>")

-- Telescope
nnoremap("<C-p>", ":Telescope")
nnoremap("<leader>ps", ":lua require(\"telescope.builtin\").grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>")
nnoremap("<C-p>", ":lua require(\"telescope.builtin\").git_files()<CR>")
nnoremap("<Leader>pf", ":lua require(\"telescope.builtin\").find_files()<CR>")
nnoremap("<leader>pw", ":lua require(\"telescope.builtin\").grep_string { search = vim.fn.expand(\"<cword>\") }<CR>")
nnoremap("<leader>pb", ":lua require(\"telescope.builtin\").buffers()<CR>")
nnoremap("<leader>vh", ":lua require(\"telescope.builtin\").help_tags()<CR>")
