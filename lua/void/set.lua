vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.opt.list = true
vim.opt.listchars:append('eol:󰌑')
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.laststatus = 0

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append('c')

vim.opt.colorcolumn = '80'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.sb = true
vim.o.spr = true

-- netrw settings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_use_errorwindow = 0

-- highlight yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
			timeout = 40
		})
  end,
  group = highlight_group,
  pattern = '*',
})
