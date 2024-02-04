local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("markdown", {
    s(
        "props",
        fmt(
            [[
        ---
        tags:
          - {}
        description: {}
        links: {}
        ---

        {}
        ]],
            { i(1), i(2), i(3), i(4) }
        )
    ),
})
