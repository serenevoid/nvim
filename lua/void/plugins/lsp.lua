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
      "j-hui/fidget.nvim"
    },
    event = { "VeryLazy" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    config = function()
      require("fidget").setup()
      require("mason").setup()
      require("mason-lspconfig").setup()
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              enable = true,
              globals = {'vim', 'use', 'bit', 'describe', 'before_each', 'after_each'},
            },
            workspace = {
              checkThirdParty = false,
              telemetry = { enable = false },
              library = {
                "$VIMRUNTIME",
              },
            },
          },
        },
      })

      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(
            function(fallback)
              if vim.snippet.active({direction = 1}) then
                vim.snippet.jump(1)
              else
                fallback()
              end
            end, {'i', 's'}
          ),
          ['<S-Tab>'] = cmp.mapping(
            function(fallback)
              if vim.snippet.active({direction = -1}) then
                vim.snippet.jump(-1)
              else
                fallback()
              end
            end, {'i', 's'}
          )
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
            { name = 'buffer' },
          })
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  },
}
