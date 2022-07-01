local M = {}

function M.nnoremap(lhs, rhs)
	vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true })
end

return M
