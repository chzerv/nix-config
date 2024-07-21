return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
        {
            -- If no Conform formatter is defined, it will automatically fall back to the
            -- formatter provided by the LSP
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            nix = { "alejandra" },
            html = { "prettier" },
            css = { "prettier" },
            json = { "prettier" },
            markdown = { "prettier", "injected" },
            graphql = { "prettier" },
            typescript = { "prettier" },
            javascript = { "prettier" },
            go = { "goimports", "gofumpt" },
            sh = { "shfmt" },
            terraform = { "terraform_fmt" },
            yaml = { "yamlfmt" },
        },

        -- Enable format on save
        format_on_save = function(bufnr)
            -- Disable autoformat for specific filetypes
            local ignore_filetypes = { "yaml" }

            if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                return
            end

            return { lsp_fallback = true }
        end,

        formatters = {
            -- https://github.com/stevearc/conform.nvim/blob/master/doc/advanced_topics.md#injected-language-formatting-code-blocks
            injected = {
                options = {
                    ignore_errors = true,
                    -- Map of treesitter language to formatters
                    lang_to_formatters = {
                        yaml = {}, -- Don't format YAML (mainly used for frontmatter)
                        html = {}, -- Don't format HTML
                    },
                },
            },

            shfmt = {
                prepend_args = { "--indent", "2" },
            },

            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4", "--quote-style", "ForceDouble" },
            },

            yamlfmt = {
                prepend_args = {
                    "-formatter",
                    "indent=2,include_document_start=true,retain_line_breaks=true,scan_folded_as_literal=true",
                },
            },
        },
    },
    -- init = function()
    --     vim.g.disable_autoformat = true
    -- end,
}
