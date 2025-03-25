local M = {}

function M.blame_line()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local blame_info = vim.fn.systemlist('git blame -L ' .. row .. ',+1 ' .. filename .. ' --porcelain')
  if blame_info[2] ~= nil then
    local hash = string.sub(blame_info[1], 1, 8)
    local author_name = string.sub(blame_info[2], 8)
    local author_date = os.date('%Y %b %d', tonumber(string.sub(blame_info[4], 12)))
    local summary = string.sub(blame_info[10], 9)
    print(hash .. " - " .. author_name .. " - " .. author_date .. " - " ..  summary)
  else
    print(blame_info[1])
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
