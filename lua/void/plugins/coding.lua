return({
  {
    'numToStr/Comment.nvim',
    config = function ()
      require('Comment').setup()
    end,
  },
  {
    'm4xshen/autoclose.nvim',
    config = function ()
      require('autoclose').setup({
        options = {
          disable_command_mode = true,
          pair_spaces = true,
          disabled_filetypes = { "text", "markdown" }
        },
      })
    end
  }
})
