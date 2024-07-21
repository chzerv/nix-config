return {
    -- {
    --     "catppuccin/nvim",
    --     lazy = false,
    --     enabled = true,
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         require("catppuccin").setup({
    --             transparent_background = true,
    --             dim_inactive = {
    --                 enabled = false,
    --                 shade = "dark",
    --                 percentage = 0.15, -- percentage of the shade to apply to the inactive window
    --             },
    --         })
    --
    --         vim.cmd.colorscheme("catppuccin-macchiato")
    --     end,
    -- },

    {
        "ribru17/bamboo.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("bamboo").setup({
                -- optional configuration here
            })
            require("bamboo").load()
        end,
    },
}
