local M = {}

local builtin = require("telescope.builtin")

-- Fall back to find_files if git_files can't find a .git directory
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
M.project_files = function()
    local opts = {}

    vim.fn.system("git rev-parse --is-inside-work-tree")

    if vim.v.shell_error == 0 then
        builtin.git_files(opts)
    else
        builtin.find_files(opts)
    end
end

-- Open telescope on my dotfiles directory
M.search_dotfiles = function()
    local opts = {
        prompt_title = "~ Dotfiles ~",
        -- shorten_path = false,
        cwd = "~/Projects/dotfiles",
    }

    builtin.find_files(opts)
end

-- Open telescope on my notes directory
M.search_notes = function()
    local opts = {
        prompt_title = "~ Notes ~",
        cwd = "~/Documents/Syncthing/Notes",
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
        cwd = vim.fn.input("Search in > ") or vim.fn.pwd,
    }

    builtin.find_files(opts)
end

return M
