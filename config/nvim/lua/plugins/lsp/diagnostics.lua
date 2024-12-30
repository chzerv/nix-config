vim.diagnostic.config({
    virtual_text = {
        prefix = "",
        spacing = 2,
        severity = { min = vim.diagnostic.severity.W },
    },

    float = {
        source = "if_many",
        border = "rounded",
    },

    underline = true,
    severity_sort = true,
    update_in_insert = false,
})

vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "<leader>cdq", vim.diagnostic.setqflist, { desc = "Open diagnostics in quickfix" })

if pcall(require, "fzf-lua") then
    vim.keymap.set("n", "<leader>cdd", "<cmd>FzfLua lsp_document_diagnostics<cr>", { desc = "Document diagnostics" })
    vim.keymap.set("n", "<leader>cdw", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
end
