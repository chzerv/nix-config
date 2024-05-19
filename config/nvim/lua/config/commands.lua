-- Open a scratch buffer
vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd 'bel 10new'

    vim.bo.filetype = "scrach"
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "hide"
end, { desc = 'Open a scratch buffer', nargs = 0 })
