return {
    "mfussenegger/nvim-dap",
    ft = { "go", "rust", "elixir" },
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            keys = {
                {
                    "<leader>de",
                    function()
                        require("dapui").eval(nil, { enter = true })
                    end,
                    desc = "Evaluate expression",
                },
                {
                    "<leader>du",
                    function()
                        require("dapui").toggle()
                    end,
                    desc = "Toggle DAP UI",
                },
            },
            opts = {
                floating = { border = "rounded" },
            },
        },

        { "theHamsta/nvim-dap-virtual-text", opts = {} },

        "leoluz/nvim-dap-go",
    },
    keys = {
        {
            "<leader>dc",
            function()
                local dap = require("dap")
                local dapui = require("dapui")
                local breakpoints = require("dap.breakpoints")

                breakpoints.clear()
                dap.disconnect()
                dap.close()
                dapui.close()
            end,
            desc = "Close DAP UI",
        },
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
    },
    config = function()
        local dap = require("dap")

        -- Automatically open DAP UI whenever a new DAP session is created
        dap.listeners.after.event_initialized["dapui_config"] = function()
            require("dapui").open({})
        end

        -- Automatically close DAP UI when a DAP session is terminated
        dap.listeners.before.event_terminated["dapui_config"] = function()
            require("dapui").close({})
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            require("dapui").close({})
        end

        -- Setup adapters
        require("plugins.dap.adapters.rust")
        require("plugins.dap.adapters.elixir")
        require("dap-go").setup()
    end,
}
