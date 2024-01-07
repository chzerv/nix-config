vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us,el"
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

local ok, surround = pcall(require, "nvim-surround")
if ok then
    -- Use via ySe or VSe
    surround.buffer_setup({
        surrounds = {
            -- Surround with LaTeX environment. Better use it with yS or VS
            -- so that the delimites are placed on new lines
            ["e"] = {
                add = function()
                    local env = require("plugins.nvim-surround").get_input("Environment > ")
                    if env then
                        return {
                            { "\\begin{" .. env .. "}" },
                            { "\\end{" .. env .. "}" },
                        }
                    end
                end,
            },
            -- Surround with LaTeX command
            ["c"] = {
                add = function()
                    local cmd = require("plugins.nvim-surround").get_input("Command >")
                    return {
                        { "\\" .. cmd .. "{" }, { "}" }
                    }
                end,
            },
        },
    })
end
