vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.foldlevel = 1
vim.opt_local.conceallevel = 2
vim.opt_local.formatoptions:append("t")

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldenable = false

vim.b.minisurround_config = {
    custom_surroundings = {
        -- Bold
        b = {
            output = { left = "**", right = "**" },
        },

        -- Italics
        i = {
            output = { left = "*", right = "*" },
        },

        -- Surround word with link from the clipboard
        l = {
            output = function()
                local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                return { left = "[", right = "](" .. clipboard .. ")" }
            end,
        },

        -- Surround visual selection with a code block of a user specified language
        c = {
            output = function()
                local lang = require("mini.surround").user_input("Enter code block language: ") or ""
                return { left = "```" .. lang .. "\n", right = "\n```" }
            end,
        },
    },
}
