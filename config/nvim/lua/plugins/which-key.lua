return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
        {
            "echasnovski/mini.icons",
            opts = {},
        },
    },
    opts = {
        icons = {
            -- set icon mappings to true if you have a Nerd Font
            mappings = false,
        },
        spec = {
            { "<leader>c", group = "Code", mode = { "n", "x" } },
            { "<leader>cd", group = "Diagnostics" },
            { "<leader>d", group = "Debug" },
            { "<leader>f", group = "Find", mode = { "n", "x" } },
            { "<leader>r", group = "Rename", mode = { "n", "x" } },
            { "<leader>g", group = "Git", mode = { "n", "x" } },
            { "<leader>t", group = "Terminal", mode = { "n", "x" } },
        },
    },
}
