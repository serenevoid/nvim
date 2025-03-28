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
    { '<leader>pf', require('telescope.builtin').find_files, desc = 'Find files' },
    { '<leader>pg', require('telescope.builtin').git_files, desc = 'Find git tracked files' },
    { '<leader>pb', require('telescope.builtin').buffers, desc = 'Find buffer' },
    { '<leader>ph', require('telescope.builtin').help_tags, desc = 'Search help tags' },
    { '<leader>p:', require('telescope.builtin').command_history, desc = 'Command history' },
    { '<leader>pd', require('telescope.builtin').diagnostics, desc = 'Workspace diagnostics' },
    {
      '<leader>ps',
      function ()
        require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })
      end,
      desc = 'Grep String'
    },
    {
      '<leader>en',
      function ()
        require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
      end,
      desc = 'Edit neovim'
    }
  },
  lazy = true
}
