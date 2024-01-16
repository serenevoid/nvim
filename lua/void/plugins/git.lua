local blame_line = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local blame_info = vim.fn.systemlist('git blame -L ' .. row .. ',+1 ' .. filename .. ' --porcelain')
  local hash = string.sub(blame_info[1], 1, 8)
  local author_name = string.sub(blame_info[2], 7)
  local author_time = string.sub(blame_info[4], 12)
  print(hash .. author_name .. strftime('%Y %b %d', author_time))
end

return ({
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>gk', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
      vim.keymap.set('n', '<leader>gj', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
      vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' })
      vim.keymap.set('n', '<leader>gb', blame_line, { desc = 'Preview blame' })
    end,
  },
})
