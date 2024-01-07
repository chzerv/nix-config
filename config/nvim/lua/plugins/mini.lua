return {
    {
        "echasnovski/mini.align",
        keys = { { "ga", mode = "x" }, { "gA", mode = "x" } },
        config = function()
            require("mini.align").setup()
        end,
    },
    {
        "echasnovski/mini.move",
        keys = { "<C-k>", "<C-j>" },
        config = function()
            require("mini.move").setup({
                mappings = {
                    left = "<C-h>",
                    right = "<C-l>",
                    down = "<C-j>",
                    up = "<C-k>",

                    line_left = "<C-h>",
                    line_right = "<C-l>",
                    line_down = "<C-j>",
                    line_up = "<C-k>",
                },
            })
        end,
    },
}
