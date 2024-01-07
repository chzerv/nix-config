return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ft = { "yaml", "python", "json", "yaml.ansible" },
    opts = {
        indent = {
            char = { "│" },
        },
        scope = {
            enabled = false
        },
        exclude = {
            buftypes = {
                "terminal",
                "nofile",
                "quickfix",
            },
            filetypes = { "help" }
        }
    },
}
