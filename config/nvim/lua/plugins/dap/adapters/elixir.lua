-- Credits: https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua#L45
local dap = require("dap")

-- elixir-debug-adapter comes with elixir-ls when using Nix
local elixir_debug_adapter = vim.fn.exepath("elixir-debug-adapter")

if elixir_debug_adapter then
    dap.adapters.mix_task = {
        type = "executable",
        command = elixir_debug_adapter,
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
            name = "phoenix",
            task = "phx.server",
            request = "launch",
            projectDir = "${workspaceFolder}",
            exitAfterTaskReturns = false,
            debugAutoInterpretAllModules = false,
        },
    }
end
