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
        "rebelot/kanagawa.nvim",
        lazy = false,
        enabled = true,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                compile = true,
                undercurl = true,
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,
                dimInactive = false,
                terminalColors = false,
                colors = {
                    theme = {
                        all = { ui = { bg_gutter = "none" } },
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {

                        -- More uniform colors for pmenu
                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },
                        BlinkCmpMenuBorder = { bg = theme.ui.bg_p1 },
                    }
                end,
                theme = "dragon", -- wave, dragon, lotus
                background = {
                    dark = "dragon",
                    light = "lotus",
                },
            })

            vim.cmd.colorscheme("kanagawa")
        end,
    },
}
