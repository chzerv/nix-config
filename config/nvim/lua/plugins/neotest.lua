return {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "jfpedroza/neotest-elixir",
    },
    keys = {
        {
            "<leader>tt",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            desc = "Test File",
        },
        {
            "<leader>tT",
            function()
                require("neotest").run.run(vim.uv.cwd())
            end,
            desc = "Run All Test Files",
        },
        {
            "<leader>tr",
            function()
                require("neotest").run.run()
            end,
            desc = "Run Nearest Test",
        },
        {
            "<leader>tl",
            function()
                require("neotest").run.run_last()
            end,
            desc = "Run Last Test",
        },
        {
            "<leader>ts",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Toggle Neotest Summary",
        },
        {
            "<leader>tS",
            function()
                require("neotest").run.stop()
            end,
            desc = "Stop Neotest",
        },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-elixir"),
            },
        })
    end,
}
