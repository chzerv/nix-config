vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4

vim.opt_global.makeprg = "go"

vim.keymap.set("n", "<leader>mr", "<cmd>make run .<cr>", { desc = "[M]ake [R]un" })
vim.keymap.set("n", "<leader>mt", "<cmd>make test -v<cr>", { desc = "[M]ake [T]est" })
