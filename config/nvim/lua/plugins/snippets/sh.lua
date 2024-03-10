local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

-- Simple placeholders
ls.add_snippets("sh", {

    ls.parser.parse_snippet("if", "if [[ ${1:cond} ]]; then\n\t${0:body}\nfi"),

    ls.parser.parse_snippet("elif", "elif [[ ${1:cond} ]]; then\n\t${0:body}"),

    s(
        "command_exists",
        fmt(
            [[
        if ! command -v {} &>/dev/null; then
            echo "{} not installed."
            exit 1
        fi
        ]],
            { i(1, "cmd"), rep(1) }
        )
    ),
})
