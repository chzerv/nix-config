return {
    "mfussenegger/nvim-dap",
    enabled = false,
    config = function()
        require("plugins.dap.setup")
    end,
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "leoluz/nvim-dap-go",
    },
}
