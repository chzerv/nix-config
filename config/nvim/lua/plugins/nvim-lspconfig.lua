return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local servers = {
            "gopls",
            "yamlls",
            "jsonls",
            "pyright",
            "lua_ls",
            "dockerls",
            "terraformls",
            "tofu_ls",
            "texlab",
            "ansiblels",
            "bashls",
            "nil_ls",
            "templ",
            "elixirls",
            "rust_analyzer",
            "taplo",
            "emmet_language_server",
            "harper_ls",
            "postgres_lsp",
        }

        local capabilities = require("blink.cmp").get_lsp_capabilities()

        vim.lsp.config("*", {
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        })

        -- Setup LSP servers
        -- Custom configuration for a server can be placed in 'plugins/lsp/servers/<server>.lua'
        -- and will be automatically included in the setup
        for _, server in ipairs(servers) do
            -- vim.lsp.config(server, opts)
            vim.lsp.enable(server)
        end
    end,
}
