local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd

-- Show trailing whitespaces and the cursorline when in normal mode
local ui_opts_grp = augroup("UI_OPTS", { clear = true })
aucmd("InsertEnter", {
    group = ui_opts_grp,
    callback = function()
        vim.opt_local.listchars:remove("trail")
        vim.opt_local.cursorline = false
    end,
    desc = "Hide trailing whitespaces and the cursorline in insert mode",
})

aucmd("InsertLeave", {
    group = ui_opts_grp,
    callback = function()
        vim.opt_local.listchars:append({ trail = "•" })
        vim.opt_local.cursorline = true
    end,
    desc = "Show trailing whitespaces and the cursorline in insert mode",
})

-- Highlight yanked text
aucmd("TextYankPost", {
    group = augroup("TextYankGroup", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = "200",
        })
    end,
    desc = "Highlight yanked text",
})

-- Disable numbers in terminal and nter insert mode.
-- This works upon starting a NEW terminal. If you want it to also apply to existing terminals, use the "TerminalEnter" event.
aucmd("TermOpen", {
    group = augroup("TerminalGroup", { clear = true }),
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.scrolloff = 0
        vim.cmd("startinsert")
    end,
    desc = "Disable numbers and scrolloff and enter insert mode when opening a terminal",
})

-- Restore cursor to the position it was last in
-- https://this-week-in-neovim.org/2023/Jan/2#tips
aucmd("BufReadPost", {
    group = augroup("RestoreCursorGroup", { clear = true }),
    callback = function()
        if vim.bo.filetype ~= "gitcommit" then
            local mark = vim.api.nvim_buf_get_mark(0, "\"")
            local lcount = vim.api.nvim_buf_line_count(0)
            if mark[1] > 0 and mark[1] <= lcount then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
        end
    end,
})

-- Automatically create a non-existing directory when writing a new file
aucmd("BufWritePre", {
    group = augroup("MkNonExDir", { clear = true }),
    callback = function()
        local path = vim.fn.expand("%:p:h")
        if vim.fn.isdirectory(path) == 0 then
            vim.fn.mkdir(path, "p")
        end
    end,
    desc = "Create non-existing dir when writing a new file",
})

-- Set formatoptions
aucmd("BufEnter", {
    group = augroup("CustomFormatOptions", {}),
    command = "set formatoptions-=cro",
})
