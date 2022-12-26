local ls = require("luasnip")

ls.add_snippets(nil,{
    lua = {
        ls.parser.parse_snippet("lf", "local $1 = function($2)\n\t$0\nend")
        },
})
