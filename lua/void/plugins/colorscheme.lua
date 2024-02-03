local function color(colorscheme)
  colorscheme = colorscheme or "rose-pine"
  vim.cmd.colorscheme(colorscheme)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  { "nvim-tree/nvim-web-devicons" },
  { "rose-pine/neovim",
    name = "rose-pine",
    event = { "BufEnter" },
    config = function ()
      require("rose-pine").setup({
        disable_background = true
      })
      color()
    end,
  }
}
