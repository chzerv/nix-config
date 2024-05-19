-- All credits to: https://github.com/mfussenegger/nvim-ansible/
-- Replace the "tasks" directory with "files" and "templates" and add the directories to the "path"
-- E.g., If we are in $HOME/projects/ansible/tasks/main.yml, "path" contains:
--  + $HOME/projects/ansible/tasks/*
--  + $HOME/projects/ansible/files/*
--  + $HOME/projects/ansible/templates/*
local fname = vim.api.nvim_buf_get_name(0)
if fname:find("tasks/") then
    local paths = {
        vim.bo.path,
        vim.fs.dirname(fname:gsub("tasks/", "files/")),
        vim.fs.dirname(fname:gsub("tasks/", "templates/")),
        vim.fs.dirname(fname),
    }
    vim.bo.path = table.concat(paths, ",")
end
