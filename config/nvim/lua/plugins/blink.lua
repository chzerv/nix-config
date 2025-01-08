return {
    "saghen/blink.cmp",
    lazy = false,
    build = "nix run .#build-plugin",
    opts = {
        keymap = {
            preset = "default",
            ["<C-p>"] = { "show", "select_prev", "fallback" },
            ["<C-n>"] = { "show", "select_next", "fallback" },
            ["<Up>"] = { "show", "select_prev", "fallback" },
            ["<Down>"] = { "show", "select_next", "fallback" },
            ["<C-e>"] = { "show_documentation", "hide_documentation" },

            ["<Tab>"] = {
                function(cmp)
                    return cmp.select_next()
                end,
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = {
                function(cmp)
                    return cmp.select_prev()
                end,
                "snippet_backward",
                "fallback",
            },
        },

        completion = {
            list = {
                selection = { preselect = true, auto_insert = true },
            },

            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind", gap = 1 },
                    },
                    treesitter = { "lsp" },
                },
                auto_show = function(ctx)
                    return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
                end,
            },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
                update_delay_ms = 25,
                window = {
                    max_height = 15,
                    border = "rounded",
                },
            },
        },

        signature = {
            enabled = true,
            window = {
                border = "rounded",
                scrollbar = true,
            },
        },

        snippets = { preset = "luasnip" },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },

            per_filetype = {
                sql = { "dadbod" },
            },

            providers = {
                buffer = { min_keyword_length = 3 },

                -- Only show snippets and suggestions from the buffer if there are no path suggestions.
                path = {
                    fallbacks = { "snippets", "buffer" },
                },

                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            },
        },
    },
}
