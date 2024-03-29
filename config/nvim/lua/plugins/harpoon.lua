return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
        local harpoon = require("harpoon")
        local extensions = require("harpoon.extensions")

        harpoon:setup()

        harpoon:extend(extensions.builtins.navigate_with_number())

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():append()
        end)

        vim.keymap.set("n", "<C-p>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end)

        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end)

        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end)

        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end)

        -- Open buffer in a split or a tab
        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-s>", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-t>", function()
                    harpoon.ui:select_menu_item({ tabedit = true })
                end, { buffer = cx.bufnr })
            end,
        })
    end,
}
