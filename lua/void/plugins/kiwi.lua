return ({
  {
    dir = '$HOME/dev/projects/kiwi.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    keys = {
      { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
      { "<leader>t", ":lua require(\"kiwi\").todo.toggle()<cr>", desc = "Toggle Markdown Task" }
    },
    lazy = true
  }
})
