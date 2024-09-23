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
}

local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
)

-- Setup LSP servers
-- Custom configuration for a server can be placed in 'plugins/lsp/servers/<server>.lua'
-- and will be automatically included in the setup
for _, server in ipairs(servers) do
    local opts = {
        capabilities = capabilities,
    }

    local has_custom_opts, custom_opts = pcall(require, "plugins.lsp.servers." .. server)

    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", custom_opts, opts)
    end

    lspconfig[server].setup(opts)
end
