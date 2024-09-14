return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit", "Gclog", "Gedit", "Gsplit", "Gread" },
        keys = {
            {
                "<leader>gg",
                function()
                    vim.cmd([[
                    :tabnew | Git
                    wincmd o
                    ]])
                end,
                desc = "Git status",
            },
            {
                "<leader>gl",
                function()
                    vim.cmd([[
                    :tabnew | Gclog
                    ]])
                end,
                desc = "Git log",
            },
            {
                "<leader>gh",
                function()
                    vim.cmd([[
                    :0Gclog
                    ]])
                end,
                desc = "Git log for the current buffer",
            },
        },
    },
}
