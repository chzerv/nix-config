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
        -- Credits to MariaSolOs: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua#L163
        local hover = vim.lsp.buf.hover

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.buf.hover = function()
            return hover({
                border = "rounded",
                focusable = true,
                max_height = math.floor(vim.o.lines * 0.5),
                max_width = math.floor(vim.o.columns * 0.4),
            })
        end

        local signature_help = vim.lsp.buf.signature_help

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.buf.signature_help = function()
            return signature_help({
                border = "rounded",
                focusable = true,
                max_height = math.floor(vim.o.lines * 0.5),
                max_width = math.floor(vim.o.columns * 0.4),
            })
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LSPAttachAugroup", { clear = true }),
            callback = function(args)
                local bufnr = args.buf
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "No valid client found!")

                vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "Go to definition" })
                vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "Go to type definition" })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0, desc = "Find references" })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Go to declaration" })

                vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, { buffer = 0 })

                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0, desc = "Rename symbol" })

                if pcall(require, "fzf-lua") then
                    vim.keymap.set(
                        "n",
                        "<leader>cs",
                        "<cmd>FzfLua lsp_document_symbols<cr>",
                        { buffer = 0, desc = "Document symbols" }
                    )

                    vim.keymap.set(
                        "n",
                        "<leader>cS",
                        "<cmd>FzfLua lsp_workspace_symbols<cr>",
                        { buffer = 0, desc = "Workspace symbols" }
                    )

                    vim.keymap.set(
                        "n",
                        "<leader>ca",
                        "<cmd>FzfLua lsp_code_actions<CR>",
                        { buffer = 0, desc = "Code actions" }
                    )
                else
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "Code actions" })
                end

                -- Enable inlay hints
                require("plugins.lsp.handlers").inlay_hints(client, bufnr)

                -- Highlight word under the cursor
                require("plugins.lsp.handlers").document_highlight(client, bufnr)

                -- LSP Folding
                require("plugins.lsp.handlers").folding(client, bufnr)
            end,
        })

        -- Configure diagnostics
        require("plugins.lsp.diagnostics")

        -- Configure LSP servers
        require("plugins.lsp.servers")
    end,
}
