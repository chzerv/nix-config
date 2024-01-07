local M = {
    "kylechui/nvim-surround",
    keys = { "ys", "cs", "ds" },
}

function M.config()
    local surround = require("nvim-surround")
    surround.setup()

    -- https://github.com/kylechui/nvim-surround/issues/109#issuecomment-1194034971
    require("nvim-surround.buffer").format_lines = function(_, _)
        -- Do nothing
    end
end

function M.get_input(prompt)
    local ok, input = pcall(vim.fn.input, { prompt = prompt })
    if not ok then
        return nil
    end
    return input
end

return M
