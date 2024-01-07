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
            },
            {
                "<leader>gl",
                function()
                    vim.cmd([[
                    :tabnew | Gclog
                    ]])
                end,
            },
            {
                "<leader>gh",
                function()
                    vim.cmd([[
                    :0Gclog
                    ]])
                end,
            },
        },
    },
}
