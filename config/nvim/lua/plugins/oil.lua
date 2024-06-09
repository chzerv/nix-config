return {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "-",
            function()
                require("oil").open()
            end,
        },

        {
            "<leader>-",
            function()
                require("oil").toggle_float()
            end,
        },
    },
}
