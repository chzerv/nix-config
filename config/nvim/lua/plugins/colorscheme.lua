return {
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        enabled = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.g.gruvbox_material_background = "medium" -- hard, medium, soft
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_disable_italic_comment = 0
            vim.g.gruvbox_material_enable_bold = 0
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_transparent_background = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

            vim.cmd.colorscheme("gruvbox-material")
        end,
    },

    {
        "sainnhe/everforest",
        lazy = false,
        enabled = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.g.everforest_background = "hard" -- hard, medium, soft
            vim.g.everforest_better_performance = 1
            vim.g.everforest_disable_italic_comment = 0
            vim.g.everforest_enable_bold = 0
            vim.g.everforest_enable_italic = 1
            vim.g.everforest_transparent_background = 0
            vim.g.everforest_diagnostic_virtual_text = "colored"

            vim.cmd.colorscheme("everforest")
        end,
    },

    {
        "vague2k/vague.nvim",
        lazy = false,
        enabled = false,
        priority = 1000,
        config = function()
            require("vague").setup({
                transparent = false,
            })

            vim.cmd.colorscheme("vague")
        end,
    },
    {
        "webhooked/kanso.nvim",
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            -- Default options:
            require("kanso").setup({
                bold = true,
                italics = true,
                compile = true,
                undercurl = true,
                commentStyle = { italic = true },
                transparent = false,
                dimInactive = true,
                terminalColors = true,
                overrides = function(colors)
                    return {
                        WinSeparator = { fg = colors.palette.inkAqua },
                    }
                end,
                theme = "ink", -- "zen", "ink", "pearl"
                background = {
                    dark = "ink",
                    light = "pearl",
                },
            })

            vim.cmd.colorscheme("kanso")
        end,
    },
}
