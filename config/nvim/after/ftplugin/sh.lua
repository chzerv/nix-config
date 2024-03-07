vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

vim.opt_global.makeprg = "shellcheck -f tty %"

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     group = vim.api.nvim_create_augroup("FTPLUGIN", { clear = true }),
--     callback = function ()
--         vim.cmd("make! <afile> | silent redraw!")
--     end,
--     desc = "Run shellcheck on save",
-- })

vim.keymap.set("n", "<leader>mc", "<cmd>make<cr>", { desc = "[M]ake [C]heck" })
