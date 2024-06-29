-- Markdown enhancements
return {
    {
        "MeanderingProgrammer/markdown.nvim",
        ft = "markdown",
        name = "render-markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("render-markdown").setup({
                win_options = {
                    concealcursor = {
                        -- 'nvic': concealed text is always hidden in normal mode
                        -- 'empty string': concealed text is shown when in normal mode and the cursor is on the line
                        rendered = "",
                    },
                },
            })
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = "cd app && yarn install",
    },
}
