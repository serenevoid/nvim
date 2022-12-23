local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

-- Every unspecified option will be set to the default.
ls.setup({
	history = true,
	-- Update more often, :h events for more info.
	update_events = "TextChanged,TextChangedI",
	-- Snippets aren't automatically removed if their text is deleted.
	-- `delete_check_events` determines on which events (:h events) a check for
	-- deleted snippets is performed.
	-- This can be especially useful when `history` is enabled.
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
	-- mapping for cutting selected text so it's usable as SELECT_DEDENT,
	-- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
	store_selection_keys = "<Tab>",
	-- luasnip uses this function to get the currently active filetype. This
	-- is the (rather uninteresting) default, but it's possible to use
	-- eg. treesitter for getting the current filetype by setting ft_func to
	-- require("luasnip.extras.filetype_functions").from_cursor (requires
	-- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
	-- the current filetype in eg. a markdown-code block or `vim.cmd()`.
	ft_func = function()
		return vim.split(vim.bo.filetype, ".", true)
	end,
})

-- Keymaps
local inoremap = require("void.keymap").inoremap
local snoremap = require("void.keymap").snoremap
local opts = { noremap = true, silent = true }

local expand_or_jump = function()
    print("Hello")
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end

local jump_back = function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end

local next_choice = function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end

inoremap("<c-j>", expand_or_jump, opts)
snoremap("<c-j>", expand_or_jump, opts)
inoremap("<c-k>", jump_back, opts)
snoremap("<c-k>", jump_back, opts)
inoremap("<c-l>", next_choice, opts)

-- utility functions
local same = function(index)
  return f(function(args)
    return args[1]
  end, { index })
end

local date = function() return { os.date('%Y-%m-%d') } end

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
                    { t({ " * @param { any }" .. arg_name .. " - "}), i(insert), t({ "", "" }) }
                )
            end
			param_nodes["arg" .. arg_name] = i(insert)

			insert = insert + 1
		end
	end

    if string.find(args[2][1], "return") then
        vim.list_extend(
            nodes,
            { t({ " * ", " * @return " }), i(insert), t({ "", "" }) }
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
    all = {
        s({
            trig = "date",
            name = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            f(date, {}),
        }),
    },
    lua = {
        ls.parser.parse_snippet("lf", "local $1 = function($2)\n\t$0\nend")
    },
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
