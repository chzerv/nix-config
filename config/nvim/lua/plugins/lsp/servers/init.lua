local lspconfig = require("lspconfig")

local servers = {
    "gopls",
    "yamlls",
    "jsonls",
    "pyright",
    "lua_ls",
    "dockerls",
    "terraformls",
    "texlab",
    "ansiblels",
    "bashls",
    "nil_ls",
    "templ",
    "elixirls",
    "rust_analyzer",
    "taplo",
    "emmet_language_server",
}

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Setup LSP servers
-- Custom configuration for a server can be placed in 'plugins/lsp/servers/<server>.lua'
-- and will be automatically included in the setup
for _, server in ipairs(servers) do
    local opts = {
        capabilities = vim.deepcopy(capabilities),
    }

    local has_custom_opts, custom_opts = pcall(require, "plugins.lsp.servers." .. server)

    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", custom_opts, opts)
    end

    lspconfig[server].setup(opts)
end
