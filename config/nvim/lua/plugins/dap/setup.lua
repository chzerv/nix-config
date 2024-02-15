local dap = require("dap")
local map = vim.keymap.set

-- Setup adapters
require("plugins.dap.adapters.rust")
require("dap-go").setup()

-- Setup dapui
local dapui = require("dapui")
dapui.setup()

-- Dap signs
vim.fn.sign_define("DapBreakpointRejected", { text = "ﰸ", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➔", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

local function dap_close()
    local breakpoints = require("dap.breakpoints")

    breakpoints.clear()
    dap.disconnect()
    dap.close()
    dapui.close()
end

-- Keymaps
map("n", "<F5>", [[<cmd>lua require('dap').continue()<cr>]], { desc = "Dap Continue" })
map("n", "<F10>", [[<cmd>lua require('dap').step_over()<cr>]], { desc = "Dap Step over" })
map("n", "<F11>", [[<cmd>lua require('dap').step_into()<cr>]], { desc = "Dap Step into" })
map("n", "<F12>", [[<cmd>lua require('dap').step_out()<cr>]], { desc = "Dap Step out" })

map("n", "<leader>db", [[<cmd>lua require('dap').toggle_breakpoint()<cr>]], { desc = "[D]ap [B]reakpoint" })
map(
    "n",
    "<leader>dB",
    [[<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>]],
    { desc = "[D]ap conditional [B]reakpoint" }
)
map(
    "n",
    "<leader>dl",
    [[<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>]],
    { desc = "[D]ap [L]og Breakpoint" }
)

map("n", "<leader>dc", dap_close, { desc = "[D]ap [C]lose" })

map("n", "<leader>dh", [[<cmd>lua require('dap.ui.widgets').hover()<cr>]], { desc = "[D]ap [H]over" })

map("n", "<leader>du", [[<cmd>lua require('dapui').toggle()<cr>]], { desc = "[D]ap Toggle dap-[U]i" })

-- Automatically open dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
