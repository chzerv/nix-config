local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

-- Simple placeholders
ls.add_snippets("yaml", {
    s(
        "template",
        fmt(
            [[
        - name: {}
          ansible.builtin.template:
            src: {}
            dest: {}
            owner: {}
            group: {}
            mode: {}
            backup: {}
        ]],
            { i(1), i(2), i(3), i(4), i(5), i(6), i(7) }
        )
    ),
    s(
        "systemd",
        fmt(
            [[
        - name: {}
          ansible.builtin.systemd:
            name: {}
            state: {}
            enabled: {}
            daemon_reload: {}
            scope: {}

            {}
        ]],
            {
                i(1),
                i(2),
                c(3, { t("started"), t("stopped"), t("restarted") }),
                c(4, { t("true"), t("false") }),
                c(5, { t("false"), t("true") }),
                c(6, { t("system"), t("user"), t("global") }),
                i(7),
            }
        )
    ),
    s(
        "package",
        fmt(
            [[
        - name: {}
          ansible.builtin.package:
            name: {}
            state: {}

            {}
        ]],
            { i(1), i(2), c(3, { t("present"), t("absent"), t("latest") }), i(4) }
        )
    ),
    s(
        "apt_cache",
        fmt(
            [[
        - name: {}
          ansible.builtin.apt:
            update_cache: true
            cache_valid_time: 3600

            {}
        ]],
            { i(1), i(2) }
        )
    ),
    s(
        "debug",
        fmt(
            [[
        - name: {}
          debug:
            msg: {}

            {}
        ]],
            { i(1), i(2), i(3) }
        )
    ),
})
