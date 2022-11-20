local Remap = require("void.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local lspkind = require("lspkind")
local autopairs = require("nvim-autopairs")
require('Comment').setup()
autopairs.setup({})

-- Setup nvim-cmp.
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-,>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer', keyword_length = 5 },
    }),
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
            },
        },
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local lspconfig = require("lspconfig")

local config = function(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
            local opts = { noremap = true, silent = true, buffer = 0 }
            nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            nnoremap("<Leader>w", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            nnoremap("<Leader>dk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
            nnoremap("<Leader>dj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
            nnoremap("<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
            nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            nnoremap("<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
            nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            inoremap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            nnoremap("<Leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            nnoremap("<Leader>lca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            nnoremap("<Leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        end,
    }, _config or {})
end

-- GO LSP
lspconfig.gopls.setup(config({
    cmd = { "gopls", "serve" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}))

-- Lua LSP
require("lspconfig").sumneko_lua.setup(config({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
}))

-- HTML LSP
lspconfig.html.setup(config({}))

-- Typescript LSP
lspconfig.tsserver.setup(config({}))

-- Python LSP
lspconfig.pyright.setup(config({}))

-- Rust LSP
lspconfig.rust_analyzer.setup(config({}))
