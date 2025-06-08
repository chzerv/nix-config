return {
    "MagicDuck/grug-far.nvim",
    lazy = false,
    cmd = { "GrugFar", "GrugFarWithin" },
    keys = {
        {
            "<leader>rg",
            function()
                require("grug-far").open({
                    transient = true,
                    prefills = {
                        search = vim.fn.expand("<cword>"),
                        paths = vim.fn.expand("%"),
                    },
                })
            end,
            desc = "GrugFar",
            mode = { "n", "v" },
        },
        {
            "<leader>rG",
            function()
                require("grug-far").open({
                    transient = true,
                    visualSelectionUsage = "operate-within-range",
                })
            end,
            desc = "GrugFar in visual selection",
            mode = { "n", "x" },
        },
    },
    opts = {
        -- Compact UI
        helpLine = {
            enabled = false,
        },
        showCompactInputs = true,
        showInputsTopPadding = false,
        showInputsBottomPadding = false,
    },
}
