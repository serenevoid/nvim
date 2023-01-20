local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node

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
	if string.find(args[1][1], ", ") then
		vim.list_extend(nodes, { t({ " * ", "" }) })
	end

	local insert = 2
    if args[1][1] ~= "" then
        for _, arg in ipairs(vim.split(args[1][1], ", ", true)) do
            -- Get actual name parameter.
            local arg_name = vim.split(arg, ": ", true)[1]
            local arg_type = vim.split(arg, ": ", true)[2]
            if arg_name then
                if arg_type then
                    vim.list_extend(
                        nodes,
                        { t({ " * @param {" .. arg_type .. "} " ..
                        arg_name .. " - "}), i(insert), t({ "", "" }) }
                    )
                else
                    vim.list_extend(
                        nodes,
                        { t({ " * @param {any} " .. arg_name ..
                        " - "}), i(insert), t({ "", "" }) }
                    )
                end
                param_nodes["arg" .. arg_name] = i(insert)

                insert = insert + 1
            end
        end
	end

    if args[2][1] then
        if args[2][1] ~= "void" then
            vim.list_extend(
                nodes,
                { t({ " * @return {" .. args[2][1] .. "} " }), i(insert), t({ "", "" }) }
            )
            param_nodes.ret = i(insert)
            insert = insert + 1
        end
	end

	vim.list_extend(nodes, { t({ " */" }) })

	local snip = sn(nil, nodes)
	-- Error on attempting overwrite.
	snip.old_state = param_nodes
	return snip
end

local same = function(index)
    return f(function(args)
        return args[1]
    end, { index })
end

-- Snippets
ls.add_snippets(nil, {
    typescript = {
        s({
            trig = "fn",
            name = "logger",
            dscr = "Console log function",
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
            t("): "),
            i(4),
            t({ " {", "\t" }),
            i(0),
            t({ "", "}" }),
        }),
        s({
            trig = "cl",
            name = "Console Log",
            dscr = "Console log method"
        },{
            t({ "console.log(" }),
            i(0),
            t({ ");" }),
        }),
    },
})
