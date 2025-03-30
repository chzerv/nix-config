return {
    "mfussenegger/nvim-dap",
    ft = { "go", "rust", "elixir" },
    dependencies = {
        "leoluz/nvim-dap-go",
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            -- stylua: ignore
            keys = {
                { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle dap-ui" },
                { "<leader>de", function() require("dapui").eval() require("dapui").eval() end, desc = "Evaluate expression" },
            },
        },
        { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },

  -- stylua: ignore
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint condition" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },

    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

    config = function()
        local dapui = require("dapui")
        local dap = require("dap")

        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Setup debugging for Go
        require("dap-go").setup()

        -- Setup debugging for Elixir
        local elixir_debug_adapter = vim.fn.exepath("elixir-debug-adapter")

        if elixir_debug_adapter ~= "" then
            dap.adapters.mix_task = {
                type = "executable",
                command = elixir_debug_adapter,
                args = {},
            }

            dap.configurations.elixir = {
                {
                    type = "mix_task",
                    name = "mix test",
                    task = "test",
                    taskArgs = { "--trace" },
                    request = "launch",
                    startApps = true, -- for Phoenix projects
                    projectDir = "${workspaceFolder}",
                    requireFiles = {
                        "test/**/test_helper.exs",
                        "test/**/*_test.exs",
                    },
                },
                {
                    type = "mix_task",
                    name = "phoenix.server",
                    request = "launch",
                    task = "phx.server",
                    projectDir = "${workspaceFolder}",
                    exitAfterTaskReturns = false,
                    debugAutoInterpretAllModules = false,
                },
            }
        end
    end,
}
