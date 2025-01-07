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
        "folke/tokyonight.nvim",
        lazy = false,
        enabled = true,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                -- use the night style
                style = "moon",
                transparent = true,
                dim_inactive = true,
                -- disable italic for functions
                styles = {
                    functions = {},
                },
                -- Change the "hint" color to the "orange" color, and make the "error" color bright red
                on_colors = function(colors)
                    colors.hint = colors.orange
                    colors.error = "#ff0000"
                end,
            })

            vim.cmd.colorscheme("tokyonight")
        end,
    },
}
