local noremap = function(lhs, rhs, desc)
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
end

noremap("<leader>ca", function()
    vim.cmd.RustLsp("codeAction")
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, "Code Action")

noremap("<leader>rr", function()
    vim.cmd.RustLsp("runnables")
end, "[R]ust [R]unnables")

noremap("<leader>rd", function()
    vim.cmd.RustLsp("debuggables")
end, "[R]ust [D]ebuggables")

noremap("<leader>rc", function()
    vim.cmd.RustLsp("openCargo")
end, "[R]ust open [C]argo")

noremap("<leader>rR", function()
    vim.cmd.RustLsp("reloadWorkspace")
end, "[R]ust [R]eload Workspace")

noremap("<leader>K", function()
    vim.cmd.RustLsp("externalDocs")
end, "Documentation in docs.rs")

vim.cmd("compiler cargo")

-- Make quickfix window show up automatically after 'make'
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "[^l]*",
    command = "cwindow",
    nested = true,
})

noremap("<leader>mb", "<cmd>make build<cr>", "[M]ake [B]uild")
noremap("<leader>mb", "<cmd>make clippy -q<cr>", "[M]ake [C]lippy")
