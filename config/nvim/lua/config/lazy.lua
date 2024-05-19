-- Bootstrap 'lazy.nvim'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Download lazy.nvim if it doesn't exist
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

-- Add 'lazypath' to the runtimepath so Neovim can find it
vim.opt.rtp:prepend(lazypath)

-- Setup lazy, and load my `lua/plugins/` folder
require("lazy").setup({ import = "plugins" }, {
    defaults = { lazy = true },
    change_detection = { enabled = false },
    checker = { enabled = false },
    performance = {
        cache = { enabled = true },
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "rplugin",
                "tarPlugin",
                "zipPlugin",
                "tohtml",
                "tutor",
            },
        },
    },
})
