local map = vim.keymap.set
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

-- Wrapper to easily create mappings for functions defined in telescope/custom.lua
local map_custom_func = function(lhs, func, opts)
    local default_opts = {
        noremap = true,
        silent = true,
    }

    opts = vim.tbl_deep_extend("force", opts or {}, default_opts)

    map("n", lhs, "<cmd>lua require'plugins.telescope.custom'." .. func .. "()<CR>", opts)
end

map("n", "<localleader>t", "<cmd>Telescope<cr>")

map("n", "<localleader>r", "<cmd>Telescope resume<cr>")

map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })

map({ "n", "x" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch for [W]ord under cursor" })

map("n", "<leader>sl", builtin.live_grep, { desc = "[S]earch using [L]ive grep" })

map("n", "<leader>so", builtin.oldfiles, { desc = "[S]earch [O]ld files" })

map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [O]ld files" })

vim.keymap.set("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzy search in the current buffer" })

map("n", "<leader>,", builtin.buffers, { desc = "[b] Find open buffers" })

map_custom_func("<leader>sW", "prompt_grep_string", { desc = "Prompt for the word to grep for" })

map_custom_func("<leader>sF", "prompt_find_files", { desc = "Prompt for files to search for" })

map_custom_func("<leader>sn", "search_notes", { desc = "[S]earch [N]otes" })

map("n", "<leader>sc", function()
    builtin.git_bcommits(themes.get_ivy())
end, { desc = "[S]earch [C]ommits" })
