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

return M
