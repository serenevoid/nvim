local default_settings = {
  theme = "dropdown",
  previewer = false,
  prompt_title = false
}

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim'
  },
  extensions = {
    fzf = {}
  },
  opts = {
    defaults = {
      preview = {
        filesize_limit = 0.1,
      },
    },
    pickers = {
      find_files = default_settings,
      git_files = default_settings,
      buffers = default_settings,
      help_tags = default_settings,
      command_history = default_settings,
    },
  },
  keys = {
    { '<leader>pf', function () require('telescope.builtin').find_files() end, desc = 'Find files' },
    { '<leader>pg', function () require('telescope.builtin').git_files() end, desc = 'Find git tracked files' },
    { '<leader>pb', function () require('telescope.builtin').buffers() end, desc = 'Find buffer' },
    { '<leader>ph', function () require('telescope.builtin').help_tags() end, desc = 'Search help tags' },
    { '<leader>p:', function () require('telescope.builtin').command_history() end, desc = 'Command history' },
    { '<leader>pd', function () require('telescope.builtin').diagnostics() end, desc = 'Workspace diagnostics' },
    { '<leader>ps', function () require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') }) end, desc = 'Grep string' },
    { '<leader>py', function () local word = vim.fn.getreg('"') require('telescope.builtin').grep_string({ search = word }) end, desc = 'Grep selected string' },
    { '<leader>en', function () require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') }) end, desc = 'Edit neovim' }
  },
  lazy = true
}
