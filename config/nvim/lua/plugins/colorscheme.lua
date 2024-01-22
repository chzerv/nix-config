return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        enabled = false,
        config = function()
            require("onedark").setup({
                style = "darker",
            })
            require("onedark").load()
        end,
    },

    {
        "sainnhe/gruvbox-material",
        lazy = false,
        enabled = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_disable_italic_comment = 0
            vim.g.gruvbox_material_enable_bold = 0
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_transparent_background = 0
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        enabled = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                light_style = "day",
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                    functions = {},
                    variables = {},
                    sidebars = "dark",
                    floats = "dark",
                },
                sidebars = { "qf", "help" },
                day_brightness = 0.3,
                hide_inactive_statusline = false,
                dim_inactive = true,
                lualine_bold = false,
            })

            vim.cmd.colorscheme("tokyonight")
        end,
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        enabled = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("github-theme").setup({
                options = {
                    -- Compiled file's destination location
                    compile_path = vim.fn.stdpath("cache") .. "/github-theme",
                    compile_file_suffix = "_compiled", -- Compiled file suffix
                    hide_end_of_buffer = false, -- Hide the '~' character at the end of the buffer for a cleaner look
                    hide_nc_statusline = true, -- Override the underline style for non-active statuslines
                    transparent = false, -- Disable setting background
                    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                    dim_inactive = true, -- Non focused panes set to alternative background
                    module_default = true, -- Default enable value for modules
                    styles = { -- Style to be applied to different syntax groups
                        comments = "italic", -- Value is any valid attr-list value `:help attr-list`
                        functions = "NONE",
                        keywords = "NONE",
                        variables = "NONE",
                        conditionals = "NONE",
                        constants = "NONE",
                        numbers = "NONE",
                        operators = "NONE",
                        strings = "NONE",
                        types = "NONE",
                    },
                },
            })

            -- vim.cmd("colorscheme github_dark")
            vim.cmd("colorscheme github_light")
        end,
    },
    {
        "catppuccin/nvim",
        lazy = false,
        enabled = true,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.15, -- percentage of the shade to apply to the inactive window
                },
            })

            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
}
