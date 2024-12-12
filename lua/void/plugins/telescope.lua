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
  keys = {
    { "<leader>pf", require("telescope.builtin").find_files, desc = "Find files" },
    { "<leader>pg", require("telescope.builtin").git_files, desc = "Find git tracked files" },
    { "<leader>pb", require("telescope.builtin").buffers, desc = "Find Buffer" },
    { "<leader>ph", require("telescope.builtin").help_tags, desc = "Search Help Tags" },
    { "<leader>p:", require("telescope.builtin").command_history, desc = "Command History" },
    { "<leader>pD", require("telescope.builtin").diagnostics, desc = "Workspace diagnostics" },
    {
      "<leader>ps",
      function ()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end,
      desc = "Grep String"
    },
    {
      "<leader>en",
      function ()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Edit neovim"
    }
  },
  lazy = true
}
