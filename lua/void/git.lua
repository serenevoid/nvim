local gitsigns = require('gitsigns')
local nnoremap = require('void.keymap').nnoremap
local vnoremap = require('void.keymap').vnoremap
local silent = { silent = true }

gitsigns.setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Navigation
        nnoremap(']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        nnoremap('[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- Actions
        vnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>', silent)
        vnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>', silent)
        nnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>', silent)
        nnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>', silent)
        nnoremap('<leader>hS', gs.stage_buffer, silent)
        nnoremap('<leader>hu', gs.undo_stage_hunk, silent)
        nnoremap('<leader>hR', gs.reset_buffer, silent)
        nnoremap('<leader>hp', gs.preview_hunk, silent)
        nnoremap('<leader>hb', function() gs.blame_line{full=true} end, silent)
        nnoremap('<leader>tb', gs.toggle_current_line_blame, silent)
        nnoremap('<leader>hd', gs.diffthis, silent)
        nnoremap('<leader>hD', function() gs.diffthis('~') end, silent)
        nnoremap('<leader>td', gs.toggle_deleted, silent)
    end
})
