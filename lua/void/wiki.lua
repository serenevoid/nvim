local Path = require("plenary.path")
local home = require("os").getenv("HOME")
local nnoremap = require('void.keymap').nnoremap

local wiki = {}

wiki.create_diary_entry = function()
    local sep = Path.path.sep
    local diary_path = home .. sep .. "wiki" .. sep .. "diary"
    local diary_name = string.format(diary_path .. sep .. "%s.md", os.date "%Y_%m_%d")
    vim.fn.mkdir(diary_path, "p")
    local bufnr = vim.fn.bufnr(diary_name, true)
    for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local open_bufnr = vim.api.nvim_win_get_buf(win_id)
        if open_bufnr == bufnr then
            return vim.api.nvim_set_current_win(win_id)
        end
    end

    vim.api.nvim_win_set_buf(0, bufnr)
end

wiki.open_index = function()
    local sep = Path.path.sep
    vim.fn.mkdir(home .. sep .. "wiki", "p")
    local index_path = home .. sep .. "wiki" .. sep .. "index.md"
    local journal_dir = home .. sep .. "wiki" .. sep .. "journal"
    vim.fn.mkdir(journal_dir, "p")
    local bufnr = vim.fn.bufnr(index_path, true)
    for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local open_bufnr = vim.api.nvim_win_get_buf(win_id)
        if open_bufnr == bufnr then
            return vim.api.nvim_set_current_win(win_id)
        end
    end

    vim.api.nvim_win_set_buf(0, bufnr)
end

nnoremap("<leader>ww", ":lua require(\"void.wiki\").open_index()<CR>")
nnoremap("<leader>wd", ":lua require(\"void.wiki\").create_diary_entry()<CR>")

return wiki
