-- Open harpoon target in a vertical split.
-- All credits go to: https://www.reddit.com/r/neovim/comments/vweqbz/autocmd_to_open_harpoons_target_in_vsplit/

vim.keymap.set("n", "<C-v>", function()
    local curline = vim.api.nvim_get_current_line()
    local working_directory = vim.fn.getcwd() .. "/"
    vim.cmd("vs")
    vim.cmd("e " .. working_directory .. curline)
end, { noremap = true, silent = true, buffer = true })
