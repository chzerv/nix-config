return {
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc", "gbc", { "gc", mode = "v" } },
    config = function()
        require("Comment").setup()
        local ft = require("Comment.ft")

        ft.set("hcl", "#%s")
    end,
}
