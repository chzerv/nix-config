local dap = require("dap")
local nmap = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = desc })
end

-- Setup adapters
require("plugins.dap.adapters.rust")

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
nmap("<F5>", [[<cmd>lua require('dap').continue()<cr>]], { desc = "Dap Continue" })
nmap("<F10>", [[<cmd>lua require('dap').step_over()<cr>]], { desc = "Dap Step over" })
nmap("<F11>", [[<cmd>lua require('dap').step_into()<cr>]], { desc = "Dap Step into" })
nmap("<F12>", [[<cmd>lua require('dap').step_out()<cr>]], { desc = "Dap Step out" })

nmap("<leader>db", [[<cmd>lua require('dap').toggle_breakpoint()<cr>]], { desc = "[D]ap [B]reakpoint" })
nmap(
    "<leader>dB",
    [[<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>]],
    { desc = "[D]ap conditional [B]reakpoint" }
)
nmap(
    "<leader>dl",
    [[<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>]],
    { desc = "[D]ap [L]og Breakpoint" }
)

nmap("<leader>dc", dap_close, { desc = "[D]ap [C]lose" })

nmap("<leader>dh", [[<cmd>lua require('dap.ui.widgets').hover()<cr>]], { desc = "[D]ap [H]over" })

nmap("<leader>du", [[<cmd>lua require('dapui').toggle()<cr>]], { desc = "[D]ap Toggle dap-[U]i" })

-- Automatically open dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
