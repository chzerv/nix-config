return {
    "echasnovski/mini.clue",
    event = "VeryLazy",
    config = function()
        local miniclue = require("mini.clue")
        miniclue.setup({
            triggers = {
                -- Leader triggers
                { mode = "n", keys = "<Leader>" },
                { mode = "x", keys = "<Leader>" },

                -- Built-in completion
                { mode = "i", keys = "<C-x>" },

                -- `g` key
                { mode = "n", keys = "g" },
                { mode = "x", keys = "g" },

                -- Marks
                { mode = "n", keys = "'" },
                { mode = "n", keys = "`" },
                { mode = "x", keys = "'" },
                { mode = "x", keys = "`" },

                -- Registers
                { mode = "i", keys = "<C-r>" },
                { mode = "c", keys = "<C-r>" },

                -- Window commands
                { mode = "n", keys = "<C-w>" },

                -- `z` key
                { mode = "n", keys = "z" },
                { mode = "x", keys = "z" },

                -- '[' and ']' keys
                { mode = "n", keys = "]" },
                { mode = "n", keys = "[" },
            },

            clues = {
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.z(),
                miniclue.gen_clues.windows({
                    submode_move = true,
                    submode_navigate = true,
                    submode_resize = true,
                }),

                { mode = "n", keys = "<Leader>c", desc = "+Code" },
                { mode = "n", keys = "<Leader>d", desc = "+Debug" },
                { mode = "n", keys = "<Leader>f", desc = "+Find" },
                { mode = "n", keys = "<Leader>g", desc = "+Git" },
                { mode = "n", keys = "<Leader>r", desc = "+Replace" },
                { mode = "n", keys = "<Leader>t", desc = "+Terminal" },
            },

            window = {
                config = { width = "auto", border = "rounded" },
            },
        })
    end,
}
