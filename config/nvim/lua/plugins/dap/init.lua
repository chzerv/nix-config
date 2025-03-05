return {
    "mfussenegger/nvim-dap",
    ft = { "go", "rust", "elixir" },
    dependencies = {
        {
            "igorlfs/nvim-dap-view",
            keys = {
                {
                    "<leader>dv",
                    function()
                        require("dap-view").toggle()
                    end,
                    desc = "Toggle dav-view",
                },
            },
            opts = {},
        },

        { "theHamsta/nvim-dap-virtual-text", opts = {} },

        "leoluz/nvim-dap-go",
    },
    keys = {
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle breakpoint",
        },

        {
            "<leader>dB",
            "<cmd>FzfLua dap_breakpoints<cr>",
            desc = "List breakpoints",
        },

        {
            "<F5>",
            function()
                require("dap").continue()
            end,
            desc = "Continue",
        },

        {
            "<F10>",
            function()
                require("dap").step_over()
            end,
            desc = "Step over",
        },

        {
            "<F11>",
            function()
                require("dap").step_into()
            end,
            desc = "Step into",
        },

        {
            "<F12>",
            function()
                require("dap").step_out()
            end,
            desc = "Step Out",
        },

        {
            "<leader>ds",
            function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.scopes, { border = "rounded" })
            end,
            desc = "Open the scopes view",
        },

        {
            "<leader>dh",
            function()
                require("dap.ui.widgets").hover(nil, { border = "rounded" })
            end,
            desc = "Open the hover view",
        },
    },
    config = function()
        local dap = require("dap")

        -- Setup adapters
        require("plugins.dap.adapters.rust")
        require("plugins.dap.adapters.elixir")
        require("dap-go").setup()
    end,
}
