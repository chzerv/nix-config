-- All credits go to: https://github.com/nguyenvukhang/nvim-toggler

local M = {}

local words = {
    ["true"] = "false",
    ["yes"] = "no",
    ["on"] = "off",
    ["present"] = "absent",
}

function M.invert()
    local tbl = {}

    for k, v in pairs(words) do
        tbl[k] = v
        tbl[v] = k
    end

    local cword = vim.tbl_get(tbl, vim.fn.expand("<cword>"))

    pcall(function()
        vim.cmd("norm! ciw" .. cword)
    end)
end

return M
