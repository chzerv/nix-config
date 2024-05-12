return {
    "echasnovski/mini.surround",
    version = false,
    keys = { { "sa", mode = { "n", "v" } }, "sd", "sf", "sF", "sr", "sh", "sn" },
    config = function()
        require("mini.surround").setup()
    end,
}
