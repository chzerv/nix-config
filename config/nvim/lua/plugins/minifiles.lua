-- Open file in a split
local map_split = function(buf_id, lhs, direction)
    local minifiles = require("mini.files")

    local rhs = function()
        local window = minifiles.get_target_window()

        -- Exit if the no window exists or the cursor is on a directory
        if window == nil or minifiles.get_fs_entry().fs_type == "directory" then
            return
        end

        -- Make a new window and set it as target.
        local new_target_window
        vim.api.nvim_win_call(window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
        end)

        minifiles.set_target_window(new_target_window)

        -- Open the file and close the explorer
        minifiles.go_in()
        minifiles.close()
    end

    vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. string.sub(direction, 12) })
end

-- Toggle showing dotfiles
local show_dotfiles = true

local filter_show = function(fs_entry)
    return true
end

local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles

    local new_filter = show_dotfiles and filter_show or filter_hide

    MiniFiles.refresh({ content = { filter = new_filter } })
end

return {
    "echasnovski/mini.files",
    event = "VeryLazy",
    keys = {
        {
            "-",
            function()
                local bufname = vim.api.nvim_buf_get_name(0)
                local path = vim.fn.fnamemodify(bufname, ":p")

                if path and vim.uv.fs_stat(path) then
                    require("mini.files").open(bufname, false)
                end
            end,
            desc = "File explorer",
        },
    },
    opts = {
        mappings = {
            show_help = "?",
            go_in_plus = "<cr>",
            go_out_plus = "H",
        },
        windows = { width_nofocus = 25 },
        -- Move stuff to the minifiles trash instead of it being gone forever.
        options = { permanent_delete = false },
    },
    config = function(_, opts)
        local minifiles = require("mini.files")

        minifiles.setup(opts)

        vim.api.nvim_create_autocmd("User", {
            desc = "Add rounded corners to minifiles window",
            pattern = "MiniFilesWindowOpen",
            callback = function(args)
                vim.api.nvim_win_set_config(args.data.win_id, { border = "rounded" })
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            desc = "Add minifiles split keymaps",
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id
                map_split(buf_id, "<C-s>", "belowright horizontal")
                map_split(buf_id, "<C-v>", "belowright vertical")
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            desc = "Show hidden files",
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id
                vim.keymap.set("n", "<C-h>", toggle_dotfiles, { buffer = buf_id })
            end,
        })
    end,
}
