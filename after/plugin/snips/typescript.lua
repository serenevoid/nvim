local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node

local jsdoc = function(args)
	local nodes = {
		t({ "/**", " * " }),
		i(1, "A short Description"),
		t({ "", "" }),
	}

	-- These will be merged with the snippet; that way, should the snippet be updated,
	-- some user input eg. text can be referred to in the new snippet.
	local param_nodes = {}

	param_nodes.descr = nodes[2]

	-- At least one param.
	if string.find(args[2][1], ", ") then
		vim.list_extend(nodes, { t({ " * ", "" }) })
	end

	local insert = 2
	for _, arg in ipairs(vim.split(args[1][1], ", ", true)) do
		-- Get actual name parameter.
		local arg_name = vim.split(arg, ": ", true)[1]
		local arg_type = vim.split(arg, ": ", true)[2]
		if arg_name then
            if arg_type then
                vim.list_extend(
                    nodes,
                    { t({ " * @param {" .. arg_type .. "} " .. arg_name .. " - "}), i(insert), t({ "", "" }) }
                )
            else
                vim.list_extend(
                    nodes,
                    { t({ " * @param {any} " .. arg_name .. " - "}), i(insert), t({ "", "" }) }
                )
            end
			param_nodes["arg" .. arg_name] = i(insert)

			insert = insert + 1
		end
	end

    if string.find(args[2][1], "return") then
        vim.list_extend(
            nodes,
            { t({ " * @return " }), i(insert), t({ "", "" }) }
        )
        param_nodes.ret = i(insert)
        insert = insert + 1
	end

	vim.list_extend(nodes, { t({ " */" }) })

	local snip = sn(nil, nodes)
	-- Error on attempting overwrite.
	snip.old_state = param_nodes
	return snip
end

-- Snippets
ls.add_snippets(nil, {
    typescript = {
        s({
            trig = "fn",
            name = "JSDOC function",
            dscr = "JSDOC function template",
        }, {
            d(5, jsdoc, { 3, 4 }),
            t({ "", "" }),
            c(1, {
                t("public "),
                t("private "),
            }),
            i(2, "functionName"),
            t("("),
            i(3),
            t(")"),
            t({ " {", "\t" }),
            i(0),
            t({ "", "" }),
            c(4, {
                t(""),
                sn(nil, {
                    t({ "\treturn " }),
                    i(1),
                }),
            }),
            t({ "", "}" }),
        }),
    },
})
