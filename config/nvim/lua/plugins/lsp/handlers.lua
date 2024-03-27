local M = {}

-- Let null-ls handle formatting
function M.disable_formatting(client)
    client.server_capabilities.documentFormattingProvider = false
end

-- LSP specific mappings
function M.lsp_mappings(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set

    map("n", "K", vim.lsp.buf.hover, opts)

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "2gd", ":vsplit | lua vim.lsp.buf.definition()<CR>", opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gr", vim.lsp.buf.references, opts)

    map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, opts)

    map("n", "<leader>ct", vim.lsp.buf.type_definition, opts)
    map("n", "<leader>ci", vim.lsp.buf.implementation, opts)

    map("n", "<leader>cr", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    map("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols theme=ivy<cr>", opts)

    -- Format using the LSP provided formatter
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, opts)
    end
end

-- Format on save
function M.fmt_on_save(client, bufnr)
    local augroup = vim.api.nvim_create_augroup("Formatting", { clear = true })
    if client.supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    timeout_ms = 3000,
                })
            end,
        })
    end
end

-- Highlight symbol under cursor, if supported by the server
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor=
-- TODO: Checkout https://github.com/RRethy/vim-illuminate
function M.lsp_highlight_document(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = true,
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- Show diagnostics on a float window when you hover over a symbol
function M.popup_diagnostics_on_hover(bufnr)
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "cursor",
            }
            vim.diagnostic.open_float(nil, opts)
        end,
    })
end

function M.codelens(client, bufnr)
    if client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = bufnr,
            group = vim.api.nvim_create_augroup("CODELENS", { clear = true }),
            callback = vim.lsp.codelens.refresh,
        })
        vim.lsp.codelens.refresh()

        vim.keymap.set(
            "n",
            "<leader>cl",
            "<cmd>lua vim.lsp.codelens.run()<CR>",
            { noremap = true, silent = true, buffer = bufnr }
        )
    end
end

function M.inlay_hints(client, bufnr)
    if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        local inlay_hints_augroup = vim.api.nvim_create_augroup("inlay_hints_augroup", { clear = false })

        vim.api.nvim_create_autocmd("InsertEnter", {
            group = inlay_hints_augroup,
            desc = "Enable inlay hints",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(bufnr, false)
            end,
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            group = inlay_hints_augroup,
            desc = "Disable inlay hints",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(bufnr, true)
            end,
        })
    end
end

return M
