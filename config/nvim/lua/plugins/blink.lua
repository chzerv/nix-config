return {
    "saghen/blink.cmp",
    lazy = false,
    build = "nix run .#build-plugin",
    opts = {
        fuzzy = { implementation = "rust" },

        keymap = {
            preset = "none",
            ["<C-y>"] = { "select_and_accept" },
            ["<C-n>"] = { "show", "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "show", "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<C-k>"] = { "snippet_forward", "fallback" },
            ["<C-j"] = { "snippet_backward", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-e>"] = { "hide" },
        },

        completion = {
            list = {
                selection = { preselect = false, auto_insert = true },
            },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
                window = {
                    max_height = 15,
                },
            },
            menu = {
                -- Make the menu similar to nvim-cmp
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind", gap = 1 },
                    },
                },
            },
        },

        signature = {
            enabled = true,
        },

        snippets = { preset = "luasnip" },

        -- Disable cmdline completion
        cmdline = { enabled = false },

        sources = {
            -- When inside a comment, only enable the "buffer" source.
            default = function(ctx)
                local success, node = pcall(vim.treesitter.get_node)

                if
                    success
                    and node
                    and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
                then
                    return { "buffer" }
                else
                    return { "lsp", "snippets", "path", "buffer" }
                end
            end,

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
