return({
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "VeryLazy" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash", "c", "html", "javascript", "jsdoc", "json", "jsonc", "lua",
        "luadoc", "luap", "markdown", "markdown_inline", "python", "regex",
        "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      vim.defer_fn(function()
        pcall(vim.cmd, "TSUpdate")
      end, 0)
    end
  },
})
