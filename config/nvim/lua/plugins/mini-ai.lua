return {
    "echasnovski/mini.ai",
    event = "InsertEnter",
    opts = function()
        local mini_ai = require("mini.ai")

        return {
            custom_textobjects = {
                -- Whole buffer
                g = function()
                    local from = { line = 1, col = 1 }
                    local to = {
                        line = vim.fn.line("$"),
                        col = math.max(vim.fn.getline("$"):len(), 1),
                    }
                    return { from = from, to = to }
                end,
            },
        }
    end,
}
