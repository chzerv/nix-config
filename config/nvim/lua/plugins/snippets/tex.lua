local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local d = ls.dynamic_node
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

-- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets#latex---endless-list=
local rec_ls
rec_ls = function()
    return sn(nil, {
        c(1, {
            -- important!! Having the sn(...) as the first choice will cause infinite recursion.
            t({""}),
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, {t({"", "  \\item "}), i(1), d(2, rec_ls, {})}),
        }),
    });
end

ls.add_snippets("tex", {
    s(
        "list", fmt([[
        \begin{{{}}}
          \item {} {}
        \end{{{}}}
        {}
        ]], { c(1, { t"itemize", t"enumerate" }), i(2), d(3, rec_ls, {}), rep(1), i(4) })
    ),

    s(
        "sec", fmt([[
        \section{{{}}}
        \label{{sec-{}}}
        {}
        ]], { i(1, "section"), i(2, "label"), i(3) })
    ),

    s(
        "subsec", fmt([[
        \subsection{{{}}}
        \label{{sub-{}}}
        {}
        ]], { i(1, "subsection"), i(2, "label"), i(3) })
    ),

    s(
        "fbox-d", fmt([[
        \begin{{center}}
        \fbox{{\fbox{{\parbox{{5.5in}}{{\centering
          {}
        \end{{center}}
        ]], { i(1, "body") })
    ),

    ls.parser.parse_snippet("lim", "\\lim_{${1:n} \\to ${2:\\infty}} $0"),

    ls.parser.parse_snippet("sum", "\\sum_{${1:lower}}^{${2:upper}} $0"),

    ls.parser.parse_snippet("int", "\\int_{${1:a}}^{${2:b}} $0"),

    ls.parser.parse_snippet("begin", "\\begin{${1:environment}}\n  ${2:body}\n\\end{$1}"),

    ls.parser.parse_snippet("it", "\\item ${1:item}"),

    ls.parser.parse_snippet("equ", "\\begin{equation}\n  ${1:item}\n\\end{equation}"),

    ls.parser.parse_snippet("equ*", "\\begin{equation*}\n  ${1:item}\n\\end{equation*}"),

    ls.parser.parse_snippet("fig", [[
\\begin{figure}[!htb]
  \\centering
  \\includegraphics[${1:width=0.7\textwidth}]{${2:file}}
  \\caption{${3:caption}}
  \\label{${4:label}}
\\end{figure}
    ]]),

    ls.parser.parse_snippet("bre", [[
    \\begin{${1|equation,equation*|}}"
  ${2:left part of the equation} = \\left\\{,
    \\begin{array}{${3:ll}}
       ${4:equation1} & , ${5:condition1} \\\\\\
       ${6:equation2} & , ${7:condition2
    \\end{array}
\\right.,
\\end{$1},
    ]]),

    ls.parser.parse_snippet("underbrace", "\\$\\underbrace{${1:actual stuff}}_\\text{${2:description}}\\$ $0"),

    ls.parser.parse_snippet("tt", "\\texttt{${1:text}} $0"),
    ls.parser.parse_snippet("bf", "\\textbf{${1:text}} $0"),
    ls.parser.parse_snippet("em", "\\emph{${1:text}} $0"),

})
