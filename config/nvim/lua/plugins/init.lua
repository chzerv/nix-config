return {
    -- Seamless navigation between tmux and neovim
    {
        "christoomey/vim-tmux-navigator",
        keys = {
            { "<A-h>", "<cmd>TmuxNavigateLeft<CR>" },
            { "<A-l>", "<cmd>TmuxNavigateRight<CR>" },
            { "<A-j>", "<cmd>TmuxNavigateDown<CR>" },
            { "<A-k>", "<cmd>TmuxNavigateUp<CR>" },
        },
        init = function()
            vim.g.tmux_navigator_no_mappings = 1
        end,
    },

    -- Markdown enhancements
    {
        "preservim/vim-markdown",
        ft = "markdown",
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        -- build = function()
        --     vim.fn["mkdp#util#install"]()
        -- end,
        build = "cd app && yarn install",
    },

    -- Quick fix list enhancements
    {
        "romainl/vim-qf",
        event = "QuickFixCmdPost",
    },
}
