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
    Open_buffer(bufnr)
end

wiki.open_index = function()
    local sep = Path.path.sep
    vim.fn.mkdir(home .. sep .. "wiki", "p")
    local index_path = home .. sep .. "wiki" .. sep .. "index.md"
    local journal_dir = home .. sep .. "wiki" .. sep .. "journal"
    vim.fn.mkdir(journal_dir, "p")
    local bufnr = vim.fn.bufnr(index_path, true)
    Set_keymaps(bufnr)
    Open_buffer(bufnr)
end

wiki.create_wiki_file = function()
    local selection_start = vim.fn.getpos("'<")
    local selection_end = vim.fn.getpos("'>")
    local line = vim.fn.getline(selection_start[2], selection_end[2])
    local name = line[1]:sub(selection_start[3], selection_end[3])
    local filename = name:gsub(" ", "_"):gsub("\\", "") .. ".md"
    local sep = Path.path.sep
    local new_mkdn = '[' .. name .. "](." .. sep .. "journal" .. sep .. filename .. ")"
    local nline = line[1]:sub(0, selection_start[3] - 1) ..
        new_mkdn .. line[1]:sub(selection_end[3] + 1, string.len(line[1]))
    vim.api.nvim_set_current_line(nline)
    local journal_dir = home .. sep .. "wiki" .. sep .. "journal"
    local bufnr = vim.fn.bufnr(journal_dir .. sep .. filename, true)
    Set_keymaps(bufnr)
    Open_buffer(bufnr)
end

Set_keymaps = function(bufnr)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "v",
        "<CR>",
        ":'<,'>lua require(\"void.wiki\").create_wiki_file()<CR>",
        {
            noremap = true,
            silent = true,
            nowait = true,
        })
end

Open_buffer = function(bufnr)
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
