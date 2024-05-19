-- Enable the experimental Lua module loader
-- :help vim.loader
vim.loader.enable()

require("config.options")
require("config.autocmds")
require("config.commands")
require("config.keymaps")

require("config.lazy")
