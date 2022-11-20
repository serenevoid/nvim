local Path = require("plenary.path")
local nnoremap = require('void.keymap').nnoremap
local home = ""
if vim.loop.os_uname().sysname == "Windows_NT"
then
    home = require("os").getenv("USERPROFILE")
else
    home = require("os").getenv("HOME")
end

local wiki = {}

-- Create a new Diary entry
wiki.create_diary_entry = function()
    local sep = Path.path.sep
    local diary_path = home .. sep .. "wiki" .. sep .. "diary"
    local diary_name = string.format(diary_path ..
        sep .. "%s.md", os.date "%Y_%m_%d")
    vim.fn.mkdir(diary_path, "p")
    local bufnr = vim.fn.bufnr(diary_name, true)
    Set_buf_keymaps(bufnr)
    Open_buffer(bufnr)
end

-- Open the Index.md file of wiki and change working directory
wiki.open_index = function()
    local sep = Path.path.sep
    vim.fn.mkdir(home .. sep .. "wiki", "p")
    local index_path = home .. sep .. "wiki" .. sep .. "index.md"
    local journal_dir = home .. sep .. "wiki" .. sep .. "journal"
    vim.fn.mkdir(journal_dir, "p")
    vim.api.nvim_set_current_dir(home .. sep .. "wiki")
    local bufnr = vim.fn.bufnr(index_path, true)
    Set_buf_keymaps(bufnr)
    Open_buffer(bufnr)
end

-- Create a new Wiki entry in Journal folder on highlighting word and pressing <CR>
wiki.create_wiki_file = function()
    local selection_start = vim.fn.getpos("'<")
    local selection_end = vim.fn.getpos("'>")
    local line = vim.fn.getline(selection_start[2], selection_end[2])
    local name = line[1]:sub(selection_start[3], selection_end[3])
    local filename = name:gsub(" ", "_"):gsub("\\", "") .. ".md"
    local sep = Path.path.sep
    local new_mkdn = '[' .. name .. "](." .. sep ..
        "journal" .. sep .. filename .. ")"
    local nline = line[1]:sub(0, selection_start[3] - 1) ..
        new_mkdn .. line[1]:sub(selection_end[3] + 1, string.len(line[1]))
    vim.api.nvim_set_current_line(nline)
    local journal_dir = home .. sep .. "wiki" .. sep .. "journal"
    local bufnr = vim.fn.bufnr(journal_dir .. sep .. filename, true)
    Set_buf_keymaps(bufnr)
    Open_buffer(bufnr)
end

-- Open links when cursor is above a link and <CR> is pressed
wiki.open_link = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.fn.getline(cursor[1])
    local filename_pos = Is_link(cursor, line)
    if (filename_pos ~= nil) then
        local filename = line:sub(unpack(filename_pos))
        if (filename:sub(0, 4) ~= "http") then
            local bufnr = vim.fn.bufnr(filename, true)
            print(filename)
            if bufnr ~= -1 then
                Set_buf_keymaps(bufnr)
                Open_buffer(bufnr)
            end
        end
    end
end

wiki.toggle_todo = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.fn.getline(cursor[1])
    local box_start = 0
    local box_end = 0
    for i = 0, string.len(line) - 1, 1 do
        local char = line:sub(i, i)
        if char == "[" then
            box_start = i
            break
        end
        if i == 100 then
            error("Limit exceeded", 1)
            break
        end
    end
    if line:sub(box_start + 2, box_start + 2) == "]" then
        box_end = box_start + 2
    end
    local todo_options = { " ", "_", "-", "!", "?", "x" }
    local state = line:sub(box_start + 1, box_start + 1)
    for i, v in ipairs(todo_options) do
        if v == state then
            if i == table.maxn(todo_options) then
                i = 0
            end
            state = todo_options[i + 1]
            break
        end
    end
    local newline = line:sub(0, box_start) ..
        state .. line:sub(box_end, string.len(line))
    vim.api.nvim_set_current_line(newline)
end

-- Set window specific keymaps
Set_buf_keymaps = function(bufnr)
    local opts = { noremap = true, silent = true, nowait = true }
    local bufvmap = function(lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, "v", lhs, rhs, opts)
    end
    local bufnmap = function(lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
    end
    bufvmap("<CR>", ":'<,'>lua require(\"void.wiki\").create_wiki_file()<CR>")
    bufnmap("<CR>", ":lua require(\"void.wiki\").open_link()<CR>")
    bufnmap("T",":lua require(\"void.wiki\").toggle_todo()<CR>")
    bufnmap("<Tab>",":let @/=\"\\\\[.\\\\{-}\\\\](.\\\\{-}.md)\"<CR>n")
    bufnmap("<S-Tab>", ":let @/=\"\\\\[.\\\\{-}\\\\](.\\\\{-}.md)\"<CR>N")
end

-- Open a buffer inside the current window
Open_buffer = function(bufnr)
    vim.api.nvim_win_set_buf(0, bufnr)
end

-- Check if the cursor is on a link on the line
Is_link = function(cursor, line)
    local is_inside_link = { false, false, false, false }
    local filename_pos = {}
    for i = cursor[2] + 1, 0, -1 do
        local char = line:sub(i, i)
        if char == "[" then
            is_inside_link[1] = true
            break
        elseif char == "]" then
            is_inside_link[2] = true
        elseif char == "(" then
            is_inside_link[3] = true
            filename_pos[1] = i
        end
        if i == 100 then
            error("Limit exceeded", 1)
            break
        end
    end
    for i = cursor[2] + 1, string.len(line), 1 do
        local char = line:sub(i, i)
        if char == "]" then
            is_inside_link[2] = true
        elseif char == "(" then
            is_inside_link[3] = true
            filename_pos[1] = i + 1
        elseif char == ")" then
            is_inside_link[4] = true
            filename_pos[2] = i - 1
            break
        end
        if i == 100 then
            error("Limit exceeded", 1)
            break
        end
    end
    if (is_inside_link[1] and is_inside_link[2] and is_inside_link[3] and is_inside_link[4]) then
        return filename_pos
    else
        return nil
    end
end

nnoremap("<leader>ww", ":lua require(\"void.wiki\").open_index()<CR>")
nnoremap("<leader>wd", ":lua require(\"void.wiki\").create_diary_entry()<CR>")

return wiki
