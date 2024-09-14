return {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "▁" },
            topdelete = { text = "▔" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, l, r, opts)
                opts = opts or {}
                if type(opts) == "string" then
                    opts = { desc = opts }
                end
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            map("n", "]g", "<cmd>Gitsigns next_hunk<CR>", "Next hunk")
            map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk")

            map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk")
            map("n", "<leader>gB", "<cmd>Gitsigns blame_line<CR>", "Blame current line")

            map("n", "<leader>gb", "<cmd>Gitsigns stage_buffer<CR>", "Stage buffer")
            map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk")
            map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk")
            map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk")

            map("v", "<leader>gs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Stage hunk")

            map("v", "<leader>gr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Reset hunk")

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
    },
}
