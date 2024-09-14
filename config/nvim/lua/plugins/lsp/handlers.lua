local M = {}

-- If the server supports inlay hints, enable them, but only on normal mode
function M.inlay_hints(client, bufnr)
    if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        local inlay_hints_augroup = vim.api.nvim_create_augroup("inlay_hints_augroup", { clear = false })

        vim.api.nvim_create_autocmd("InsertEnter", {
            group = inlay_hints_augroup,
            desc = "Enable inlay hints",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(false)
            end,
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            group = inlay_hints_augroup,
            desc = "Disable inlay hints",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(true)
            end,
        })
    end
end

-- If the server supports document highlighting, highlight the word under the cursor
-- Credits to kickstart.nvim: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L550
function M.highlight_word(client, bufnr)
    if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup = vim.api.nvim_create_augroup("LSPWordHighlighting", { clear = false })

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = highlight_augroup,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("LSPDetachAugroup", { clear = true }),
            callback = function(new_args)
                vim.lsp.buf.clear_references()

                vim.api.nvim_clear_autocmds({ group = "LSPWordHighlighting", buffer = new_args.buf })
            end,
        })
    end
end

return M
