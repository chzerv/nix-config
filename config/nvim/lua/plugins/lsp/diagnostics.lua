vim.diagnostic.config({
    underline = true,
    severity_sort = true,
    update_in_insert = false,

    float = {
        source = true,
        border = "rounded",
    },
    virtual_text = {
        severity = { min = vim.diagnostic.severity.W },
        source = "if_many",
    },
})

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Open diagnostics in quickfix" })
