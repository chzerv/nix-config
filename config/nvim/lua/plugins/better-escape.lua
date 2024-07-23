-- We could do with a simple mapping, however, this plugin eliminates the delay when typing the letter 'j'
return {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
        require("better_escape").setup({
            timeout = vim.o.timeoutlen,
            default_mappings = false,
            mappings = {
                i = {
                    j = {
                        k = "<Esc>",
                    },
                },
                c = {
                    j = {
                        k = "<Esc>",
                    },
                },
            },
        })
    end,
}
