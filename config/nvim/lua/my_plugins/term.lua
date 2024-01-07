local M = {}

local term_buf = nil
local term_win = nil
local job_id = nil

function M.toggle_term(direction, size)
    if vim.fn.win_gotoid(term_win) == 1 then
        vim.cmd("hide")
    else
        if vim.fn.bufexists(term_buf) ~= 1 then
            if direction == "split" then
                vim.cmd("botright new | res " .. size)
            elseif direction == "vsplit" then
                vim.cmd("vertical new | vert res " .. size)
            end
            job_id = vim.api.nvim_call_function("termopen", { "$SHELL" })
            term_buf = vim.fn.bufnr("%")
            term_win = vim.fn.win_getid()
        else
            if direction == "split" then
                vim.cmd("sb " .. term_buf .. " | res " .. size)
            elseif direction == "vsplit" then
                vim.cmd("vert sb " .. term_buf .. " | vert res " .. size)
            end
            term_win = vim.fn.win_getid()
        end
        vim.cmd("startinsert")
    end
end

function M.launch_term_in_tab()
    vim.cmd("tabnew")
    job_id = vim.api.nvim_call_function("termopen", { "$SHELL" })
end

function M.send_line_to_term()
    if not job_id then
        vim.notify("No active terminal found", vim.log.levels.WARN)
        return
    end

    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_chan_send(job_id, line .. "\n")
end

-- All credits go to mfussenegger:
-- https://github.com/mfussenegger/dotfiles/blob/master/vim/.config/nvim/lua/term.lua#L197
function M.send_visual_to_term()
    if not job_id then
        vim.notify("No active terminal found", vim.log.levels.WARN)
        return
    end
    local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))
    local mode = vim.fn.visualmode()
    local offset
    if mode == "" then -- in block mode all following lines are indented
        offset = start_col
    elseif mode == "V" then
        end_row = end_row + 1
        offset = 0
    else
        offset = 0
    end
    local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
    for idx, line in pairs(lines) do
        local l
        if idx == 1 and idx == #lines then
            l = line:sub(start_col + 1, end_col + 1)
        elseif idx == 1 then
            l = line:sub(start_col + 1)
        elseif idx == #lines then
            l = line:sub(offset + 1, end_col > #line and #line or end_col + 1)
        elseif offset > 0 then
            l = line:sub(offset + 1)
        else
            l = line
        end
        vim.api.nvim_chan_send(job_id, l .. "\n")
    end
end

return M
