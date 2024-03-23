-------------------------------------------------------
-- Configuration for null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-------------------------------------------------------

local M = {
    "nvimtools/none-ls.nvim",
}

function M.setup()
    local nls = require("null-ls")

    local diagnostics = nls.builtins.diagnostics
    local formatting = nls.builtins.formatting
    -- local code_actions = nls.builtins.code_actions

    nls.setup({
        debug = false,
        debounce = 150,
        sources = {
            formatting.black,
            formatting.stylua.with({
                extra_args = {
                    "--quote-style",
                    "ForceDouble",
                    "--indent-width",
                    "4",
                    "--indent-type",
                    "Spaces",
                },
            }),
            formatting.prettier.with({
                filetypes = { "html", "css", "json", "markdown", "graphql", "typescript", "javascript" },
            }),
            formatting.goimports,
            formatting.terraform_fmt,
            formatting.alejandra,

            formatting.shfmt.with({
                extra_args = {
                    "--indent",
                    "2",
                },
            }),

            -- https://github.com/google/yamlfmt/blob/main/docs/config-file.md#basic-formatter
            formatting.yamlfmt.with({
                extra_args = {
                    "-formatter",
                    "indent=2,include_document_start=true,retain_line_breaks_single=true",
                },
            }),

            diagnostics.yamllint,
        },
        on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            local map = vim.keymap.set

            map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

            if client.server_capabilities.documentFormattingProvider then
                map({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, opts)
            end
        end,
    })
end

return M
