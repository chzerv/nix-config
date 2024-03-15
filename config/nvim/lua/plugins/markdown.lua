-- Markdown enhancements
return {
    {
        "preservim/vim-markdown",
        ft = "markdown",
    },

    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = "cd app && yarn install",
    },
}
