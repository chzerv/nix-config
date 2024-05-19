return {
    "mfussenegger/nvim-dap",
    ft = { "go", "rust", "elixir" },
    dependencies = {
        { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
        "theHamsta/nvim-dap-virtual-text",
        "leoluz/nvim-dap-go",
    },
    config = function()
        -- Setup dapui and nvim-dap-virtual-text with their default configurations
        require("dapui").setup()
        require("nvim-dap-virtual-text").setup()

        -- Configure nvim-dap
        require("plugins.dap.setup")
    end,
}
