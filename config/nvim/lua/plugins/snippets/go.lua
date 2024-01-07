local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

ls.add_snippets("go", {
    s(
        "err",
        fmt(
            [[
            if err != nil {{
                {}
            }}

            {}
        ]],
            { i(1), i(2) }
        )
    ),
})
