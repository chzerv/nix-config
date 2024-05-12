vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us,el"
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

vim.b.minisurround_config = {
    custom_surroundings = {
        -- Surround with LaTeX environment
        e = {
            output = function()
                local env = MiniSurround.user_input("Environment > ")
                if env then
                    return { left = "\\begin{" .. env .. "}\n", right = "\n\\end{" .. env .. "}" }
                end
            end,
        },
        -- Surround with LaTeX command
        c = {
            output = function()
                local cmd = MiniSurround.user_input("Command > ")
                return { left = "\\" .. cmd .. "{", right = "}" }
            end,
        },
    },
}
