return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        local lspkind = require("lspkind")
        lspkind.init({})

        vim.opt.completeopt = { "menu", "menuone", "noselect" }
        vim.opt.shortmess:append("c")
        vim.opt.pumheight = 10 -- Only show 10 completion candidates
        vim.opt.pumblend = 10 -- Add transparency to the pummenu

        return {
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer", keyword_length = 3 },
                { name = "nvim_lsp_signature_help" },
            },

            mapping = {
                -- If pummenu is visible, select next item. If not, trigger completion
                ["<C-n>"] = function()
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        cmp.complete()
                    end
                end,
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-y>"] = cmp.mapping(
                    cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                    { "i", "c" }
                ),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
            },

            -- Setup vim-dadbod-completion for SQL buffers
            cmp.setup.filetype({ "sql" }, {
                sources = {
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" },
                },
            }),

            -- Enable luasnip to handle snippet expansion for nvim-cmp
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
        }
    end,
}
