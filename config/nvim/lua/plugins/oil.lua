return {
    "stevearc/oil.nvim",
    -- We can't lazy load if we want to use the SSH functionality
    lazy = false,
    keys = {
        {
            "-",
            function()
                require("oil").open()
            end,
        },
    },
    opts = {},
}
