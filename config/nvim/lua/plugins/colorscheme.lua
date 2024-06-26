return {
    {
        "catppuccin/nvim",
        lazy = false,
        enabled = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15, -- percentage of the shade to apply to the inactive window
                },
            })

            vim.cmd.colorscheme("catppuccin-macchiato")
        end,
    },

    {
        "sainnhe/gruvbox-material",
        lazy = false,
        enabled = true,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.g.gruvbox_material_background = "medium"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_disable_italic_comment = 0
            vim.g.gruvbox_material_enable_bold = 0
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_transparent_background = 0
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

            vim.cmd.colorscheme("gruvbox-material")
        end,
    },
}
