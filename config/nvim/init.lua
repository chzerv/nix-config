-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Options, keymaps, autocommands etc.
require("settings")
require("keymaps")
require("autocommands")
require("commands")
require("lsp")
require("diagnostics")

-- @type LazySpec
local plugins = "plugins"

-- Setup lazy.nvim
require("lazy").setup(plugins, {
    defaults = { lazy = true },
    change_detection = { notify = false },
    install = {
        -- Do not automatically install on startup.
        missing = true,
    },
    -- I don't have any plugins that use luarocks so just disable this.
    rocks = {
        enabled = false,
    },
    performance = {
        rtp = {
            -- Stuff I don't use.
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "rplugin",
                "zipPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
            },
        },
    },
})
