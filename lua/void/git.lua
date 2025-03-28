local M = {
  nsId = vim.api.nvim_create_namespace('git'),
  extId = nil,
  bufnr = nil
}

function M.blame_line()
  if M.extId ~= nil then
    vim.api.nvim_buf_del_extmark(M.bufnr, M.nsId, M.extId)
  end
  M.bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(M.bufnr)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local blame_info = vim.fn.systemlist('git blame -L ' .. row .. ',+1 ' .. filename .. ' --porcelain')
  if blame_info[2] ~= nil then
    local hash = string.sub(blame_info[1], 1, 8)
    local author_name = string.sub(blame_info[2], 8)
    local author_date = os.date('%Y %b %d', tonumber(string.sub(blame_info[4], 12)))
    M.extId = vim.api.nvim_buf_set_extmark(M.bufnr, M.nsId, row - 1, 0, {
      virt_text = { { hash, 1 }, { " - ", 2 }, { author_name, 0 }, { " - ", 2 }, { author_date, 1 } },
      virt_text_pos = "right_align"
    })
    vim.defer_fn(function ()
      vim.api.nvim_buf_del_extmark(M.bufnr, M.nsId, M.extId)
    end, 10000)
  else
    vim.notify(blame_info[1], vim.log.levels.ERROR)
  end
end

function M.get_branch()
  if M.branch ~= nil then
    return M.branch
  end
  local branch = vim.fn.systemlist('git branch --show')
  if branch[1] == nil then
    M.branch = ""
    return nil
  end
  if string.find(branch[1], 'fatal') then
    M.branch = ""
    return nil
  else
    M.branch = " " .. branch[1]
    return M.branch
  end
end

vim.keymap.set('n', '<space>gb', M.blame_line)

return M
