local ls = require("luasnip")
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

ls.add_snippets("lua", {
    s(
        "req",
        fmt(
            [[
            local {} = require "{}"
        ]],
            {
                f(function(args)
                    local pairs = vim.split(args[1][1], ".", true)
                    return pairs[#pairs] or ""
                end, { 1 }),
                i(1),
            }
        )
    ),
    s(
        "if",
        fmt(
            [[
        if {} then
            {}
        end
        {}
        ]],
            { i(1, "condition"), i(2, "body"), i(3) }
        )
    ),
    s(
        "pcall",
        fmt(
            [[
        local ok, {} = pcall(require, "{}")
        ]],
            {
                f(function(args)
                    local pairs = vim.split(args[1][1], ".", true)
                    return pairs[#pairs] or ""
                end, { 1 }),
                i(1),
            }
        )
    ),
    s(
        "aucmd",
        fmt(
            [[
        local group = vim.api.nvim_create_augroup("{}", {{ clear = true }})
        vim.api.nvim_create_autocmd("{}", {{
           group = group,
           {} = {}
        }})
        {}
        ]],
            {
                i(1, "group name"),
                i(2, "event"),
                c(3, { t("command"), t("callback") }),
                i(4, "body"),
                i(5),
            }
        )
    ),
    s(
        "packuse",
        fmt(
            [[
        use({{
            "{}",
            config = function()
                require("plugins.{}")
            end
        }})
        ]],
            { i(1, "plugin"), i(2, "config") }
        )
    ),
})
