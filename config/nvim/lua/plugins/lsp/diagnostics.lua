local M = {}

-- Credits to LazyVim:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local function goto_diagnostic(next, severity)
    -- Choose which diagnostic to jump to - the next or previous one
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev

    severity = severity and vim.diagnostic.severity[severity]

    return function()
        go({ severity = severity })
    end
end

M.setup = function()
    vim.diagnostic.config({
        -- Don't show diagnostics at the end of the line
        virtual_text = {
            severity = nil,
            source = "if_many",
            format = nil,
            prefix = "",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            source = "always",
            border = "rounded",
            show_header = true,
            style = "minimal",
            format = function(diagnostic)
                if diagnostic.source == "" then
                    return diagnostic.message
                end

                if diagnostic.source == "ansible-lint" then
                    return string.format(
                        "%s [%s]\nMore info: %s\n",
                        diagnostic.message,
                        diagnostic.code,
                        diagnostic.user_data.lsp.codeDescription.href
                    )
                end
                return string.format("[%s] %s %s", diagnostic.source, diagnostic.code, diagnostic.message)
            end,
        },
    })

    vim.keymap.set("n", "<leader>df", function()
        vim.diagnostic.open_float({ scope = "line" })
    end, { desc = "Line diagnostics" })

    vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Open diagnostics in quickfix" })

    vim.keymap.set(
        "n",
        "<leader>dt",
        "<cmd>Telescope diagnostics theme=ivy<cr>",
        { desc = "Open diagnostics in Telescope" }
    )

    vim.keymap.set("n", "]d", goto_diagnostic(true), { desc = "Next diagnostic" })
    vim.keymap.set("n", "[d", goto_diagnostic(false), { desc = "Previous diagnostic" })
    vim.keymap.set("n", "]e", goto_diagnostic(true, "ERROR"), { desc = "Next error" })
    vim.keymap.set("n", "[e", goto_diagnostic(false, "ERROR"), { desc = "Previous error" })
    vim.keymap.set("n", "]w", goto_diagnostic(true, "WARN"), { desc = "Next warning" })
    vim.keymap.set("n", "[w", goto_diagnostic(false, "WARN"), { desc = "Previous warning" })
end

return M
