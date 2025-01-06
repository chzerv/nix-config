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
        "sainnhe/sonokai",
        lazy = false,
        enabled = true,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = "maia"
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_disable_italic_comment = 0
            vim.g.sonokai_enable_bold = 0
            vim.g.sonokai_enable_italic = 1
            vim.g.sonokai_transparent_background = 0
            vim.g.sonokai_diagnostic_virtual_text = "colored"

            vim.cmd.colorscheme("sonokai")
        end,
    },
}
