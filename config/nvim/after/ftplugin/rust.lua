local has_rust_tools, _ = pcall(require, "rust-tools")
if has_rust_tools then
    local opts = { noremap = true, silent = true, buffer = true }
    local map = vim.keymap.set

    map("n", "<leader>K", "<cmd>RustOpenExternalDocs<cr>", opts)
    map("n", "<leader>rr", "<cmd>RustRunnables<cr>", opts)
    map("n", "<leader>rd", "<cmd>RustDebuggables<cr>", opts)
    map("n", "<leader>rc", "<cmd>RustOpenCargo<cr>", opts)
    map("n", "<leader>rR", "<cmd>CargoReload<cr>", opts)
end

vim.cmd("compiler cargo")

-- Make quickfix window show up automatically after 'make'
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "[^l]*",
    command = "cwindow",
    nested = true,
})

vim.keymap.set("n", "<leader>mb", "<cmd>make build<cr>", { desc = "[M]ake [B]uild" })
vim.keymap.set("n", "<leader>mc", "<cmd>make clippy -q<cr>", { desc = "[M]ake [C]lippy" })
