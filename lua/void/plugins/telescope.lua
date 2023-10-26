return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  keys = {
    { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>pg", "<cmd>Telescope git_files<cr>", desc = "Find git tracked files" },
    { "<leader>pb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },
    { "<leader>ph", "<cmd>Telescope help_tags<cr>", desc = "Search Help Tags" },
    {
      "<leader>ps",
      ":lua require(\"telescope.builtin\").grep_string({ search = vim.fn.input(\"Grep > \") })<cr>",
      desc = "Grep String"
    },
    { "<leader>p:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>pd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>pD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" }
  },
  lazy = true
}
