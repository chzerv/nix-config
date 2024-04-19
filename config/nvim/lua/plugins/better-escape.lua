-- We could do with a simple mapping, however, this plugin eliminates the delay when typing the letter 'j'
return {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
        require("better_escape").setup({
            mapping = { "jk" },
            timeout = vim.o.timeoutlen,
            clear_empty_lines = false,
            keys = "<Esc>",
        })
    end,
}
