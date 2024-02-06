return ({
  {
    dir = '$HOME/dev/kiwi.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    keys = {
      { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
    },
    lazy = true
  }
})
