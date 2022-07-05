local Remap = require("void.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local lspconfig = require("lspconfig")

local on_attach = function()
    local opts = {noremap = true, silent = true, buffer = 0}
    nnoremap("K",           "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    nnoremap("<Leader>w",   "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    nnoremap("<Leader>dk",  "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    nnoremap("<Leader>dj",  "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    nnoremap("<Leader>q",   "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    nnoremap("gD",          "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    nnoremap("<Leader>D",   "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    nnoremap("gd",          "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    nnoremap("gi",          "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    nnoremap("gr",          "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    nnoremap("<C-k>",       "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    nnoremap("<Leader>lr",  "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    nnoremap("<Leader>lca",  "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    nnoremap("<Leader>lf",  "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'gopls', 'sumneko_lua' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    -- capabilities = capabilities,
  }
end

lspconfig.sumneko_lua.setup{
settings = {
Lua = {
diagnostics = {
globals = { 'vim' }
}
}
}
}
