local M = {}

local builtin = require("telescope.builtin")

-- Open telescope on my notes directory
M.search_notes = function()
    local opts = {
        prompt_title = "~ Notes ~",
        cwd = "~/Documents/Syncthing/Obsidian_Vault",
    }

    builtin.find_files(opts)
end

-- Prompt user for a string, and run 'Telescope grep_string search=<string>'
M.prompt_grep_string = function()
    local opts = {
        path_display = { "shorten" },
        search = vim.fn.input("Grep For > "),
    }

    builtin.grep_string(opts)
end

M.prompt_find_files = function()
    local opts = {
        path_display = { "truncate" },
        cwd = vim.ui.input({ completion = "dir", prompt = "Search in > " }, function(input)
            if not input then
                return vim.fn.pwd
            else
                return input
            end
        end),
    }

    builtin.find_files(opts)
end

return M
