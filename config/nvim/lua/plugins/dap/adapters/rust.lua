local dap = require("dap")

dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
}

dap.adapters.rust = dap.adapters.lldb

-- Credits to https://github.com/rcarriga/dotfiles/blob/master/.config/nvim/lua/config/dap.lua
-- for the `program` function
dap.configurations.rust = {
    {
        name = "Default",
        type = "lldb",
        request = "launch",
        program = function()
            vim.fn.jobstart("cargo build")
            local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
            local metadata = vim.fn.json_decode(metadata_json)
            local target_name = metadata.packages[1].targets[1].name
            local target_dir = metadata.target_directory
            return target_dir .. "/debug/" .. target_name
        end,
        -- cwd = "${workspaceFolder}",
        stopOnEntry = false,
        --runInTerminal = true,
    },
    {
        name = "Extra Arguments",
        type = "lldb",
        request = "launch",
        program = function()
            vim.fn.jobstart("cargo build")
            local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
            local metadata = vim.fn.json_decode(metadata_json)
            local target_name = metadata.packages[1].targets[1].name
            local target_dir = metadata.target_directory
            return target_dir .. "/debug/" .. target_name
        end,
        stopOnEntry = false,
        args = function()
            local input_args = vim.fn.input("Input arguments: ")
            return vim.fn.split(input_args, " ", true)
        end,
        --runInTerminal = true,
    },
}
