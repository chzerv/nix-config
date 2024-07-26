return {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
    dependencies = {
        {
            "echasnovski/mini.icons",
            opts = {},
        },
    },
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
    config = function()
        -- https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#toggle-file-detail-view
        local detail = false

        require("oil").setup({
            keymaps = {
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
            },
        })
    end,
}
