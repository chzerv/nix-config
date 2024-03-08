return {
    {
        "echasnovski/mini.align",
        keys = { { "ga", mode = "x" }, { "gA", mode = "x" } },
        config = function()
            require("mini.align").setup()
        end,
    },
}
