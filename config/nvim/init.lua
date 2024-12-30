-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- Neovim settings, keymaps, commands and autocommands that must be set before Lazy
require("options")
require("keymaps")
require("commands")
require("autocmds")

-- Configure plugins.
require("lazy").setup({ import = "plugins" }, {
    defaults = { lazy = true },
    change_detection = { enable = false },
    checker = { enabled = false },
    rocks = {
        -- I don't have any plugins that use luarocks, so just disable it
        enabled = false,
    },
    ui = { border = "rounded" },
    git = {
        timeout = 1000,
    },
    performance = {
        cache = { enabled = true },
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "rplugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "tarPlugin",
            },
        },
    },
    -- Profiling introduces some overhead, so only enable it when debugging
    profiling = {
        -- Enables extra stats on the debug tab related to the loader cache.
        -- Additionally gathers stats about all package.loaders
        loader = false,
        -- Track each new require in the Lazy profiling tab
        require = false,
    },
})
