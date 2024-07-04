return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim"
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    config = function()
      require("fidget").setup()
      require("mason").setup()
      require("mason-lspconfig").setup({
        handlers = {
          function (server_name)
            require("lspconfig")[server_name].setup({})
          end,
          ["lua_ls"] = function ()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT',
                  },
                  diagnostics = {
                    enable = true,
                    globals = {'vim', 'use'},
                  },
                  workspace = {
                    checkThirdParty = false,
                    telemetry = { enable = false },
                    library = {
                      "${3rd}/love2d/library",
                      vim.api.nvim_get_runtime_file('', true),
                    },
                  },
                },
              },
            })
          end
        }
      })

      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true })
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }
        }, {
            { name = 'buffer' },
          })
      })
    end
  },
}
