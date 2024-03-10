local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

local function fd_cmt_string(cmt)
    return string.format(vim.bo.commentstring, "" .. cmt)
end

-- Simple placeholders
ls.add_snippets("all", {
    s(
        "date",
        f(function()
            return os.date("%D - %H:%M")
        end)
    ),
    s(
        "todo",
        c(1, {
            t(fd_cmt_string("TODO: ")),
            t(fd_cmt_string("FIXME: ")),
        }),
        i(0)
    ),
    s("ft", t(fd_cmt_string("vi: set ft=yaml :"))),

    s("shebang", c(1, { t("#!/usr/bin/env bash"), t("#!/usr/bin/env fish") })),
})
