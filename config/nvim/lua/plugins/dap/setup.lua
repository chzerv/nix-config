-- Amazing video from TJ on nvim-dap: https://www.youtube.com/watch?v=lyNfnI-B640
local dap = require("dap")
local map = vim.keymap.set

-- Setup adapters
require("plugins.dap.adapters.rust")
require("plugins.dap.adapters.elixir")
require("dap-go").setup()

-- Setup dapui
local dapui = require("dapui")

local function dap_close()
    local breakpoints = require("dap.breakpoints")

    breakpoints.clear()
    dap.disconnect()
    dap.close()
    dapui.close()
end

-- Keymaps
map("n", "<leader>du", dapui.toggle)
map("n", "<leader>dc", dap_close)

map("n", "<space>db", dap.toggle_breakpoint)
map("n", "<space>gb", dap.run_to_cursor)

-- Eval var under cursor
map("n", "<space>?", function()
    require("dapui").eval(nil, { enter = true })
end)

map("n", "<F5>", dap.continue)
map("n", "<F6>", dap.step_over)
map("n", "<F7>", dap.step_into)
map("n", "<F8>", dap.step_out)
map("n", "<F9>", dap.step_back)
map("n", "<F12>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end
