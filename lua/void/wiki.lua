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

-- Open the Index.md file of wiki and change working directory
wiki.open_index = function()
    local sep = Path.path.sep
    local wiki_dir = home .. sep .. "wiki"
    local path = Path:new(wiki_dir)
    if not path:exists() then
        path:mkdir()
    end
    local index_path = home .. sep .. "wiki" .. sep .. "index.md"
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
    local new_mkdn = '[' .. name .. "]"
    local nline = line[1]:sub(0, selection_start[3] - 1) ..
        new_mkdn .. line[1]:sub(selection_end[3] + 1, string.len(line[1]))
    vim.api.nvim_set_current_line(nline)
    local journal_dir = home .. sep .. "wiki" .. sep .. "journal"
    local path = Path:new(journal_dir)
    if not path:exists() then
        path:mkdir()
    end
    local bufnr = vim.fn.bufnr(journal_dir .. sep .. filename, true)
    Set_buf_keymaps(bufnr)
    Open_buffer(bufnr)
end

-- Open links when cursor is above a link and <CR> is pressed
wiki.open_link = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.fn.getline(cursor[1])
    local filename = Is_link(cursor, line)
    if (filename ~= nil and filename:len() > 1) then
        filename = filename:gsub(" ", "_")
        local sep = Path.path.sep
        local journal_dir = home .. sep .. "wiki" .. sep .. "journal"
        local bufnr = vim.fn.bufnr(journal_dir .. sep .. filename .. ".md", true)
        if bufnr ~= -1 then
            Set_buf_keymaps(bufnr)
            Open_buffer(bufnr)
        end
    end
end

-- Toggle check box
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
    local todo_options = { " ", "x" }
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
    vim.wo.conceallevel = 2
    bufvmap("<CR>", ":'<,'>lua require(\"void.wiki\").create_wiki_file()<CR>")
    bufnmap("<CR>", ":lua require(\"void.wiki\").open_link()<CR>")
    bufnmap("<Tab>", ":let @/=\"\\\\[.\\\\{-}\\\\]\"<CR>nl")
    bufnmap("<S-Tab>", ":let @/=\"\\\\[.\\\\{-}\\\\]\"<CR>Nl")
    bufnmap("<Leader>x",":lua require(\"void.wiki\").toggle_todo()<CR>")
end

-- Open a buffer inside the current window
Open_buffer = function(bufnr)
    vim.api.nvim_win_set_buf(0, bufnr)
end

-- Check if the cursor is on a link on the line
Is_link = function(cursor, line)
    local filename_bounds = {}
    for i = cursor[2], 0, -1 do
        if (line:sub(i, i) == "]") then
            return nil
        end
        if (line:sub(i, i) == "[") then
            filename_bounds[1] = i + 1
            break
        end
    end
    for i = cursor[2] + 2, line:len(), 1 do
        if (line:sub(i, i) == "[") then
            return nil
        end
        if (line:sub(i, i) == "]") then
            filename_bounds[2] = i - 1
            break
        end
    end
    if (filename_bounds[1] ~= nil and filename_bounds[2] ~= nil) then
        return line:sub(unpack(filename_bounds))
    end
end

nnoremap("<leader>ww", ":lua require(\"void.wiki\").open_index()<CR>")

return wiki
