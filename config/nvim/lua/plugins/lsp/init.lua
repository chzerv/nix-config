return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "j-hui/fidget.nvim",
            opts = { notification = { window = { winblend = 0 } } },
        },
    },
    config = function()
        local lspconfig = require("lspconfig")
        require("plugins.lsp.diagnostics")

        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )

        -- Prettier hover and signature help
        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true, max_height = 20 })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = "rounded", silent = true, max_height = 20, relative = "cursor" }
        )

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
        }

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

        -- Filetypes to disable semantic tokens for
        local disable_semantic_tokens_ft = {
            lua = true,
        }

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "No valid client found!")

                vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
                vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

                vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, { buffer = 0 })

                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })

                local fzf_installed, _ = pcall(require, "fzf-lua")

                if fzf_installed then
                    vim.keymap.set("n", "<leader>cs", "<cmd>FzfLua lsp_workspace_symbols<cr>", { buffer = 0 })
                end

                local ft = vim.bo[bufnr].filetype

                if disable_semantic_tokens_ft[ft] then
                    client.server_capabilities.semanticTokensProvider = nil
                end

                -- Enable inlay hints
                require("plugins.lsp.handlers").inlay_hints(client, bufnr)
            end,
        })
    end,
}
