-- Disable inlay hints by default. Can be turned on using the `ToggleInlayHints` command
vim.g.inlay_hints = false

--@param bufnr integer
local function setup_lsp_keymaps(bufnr)
    -- grn    -> vim.lsp.buf.rename()
    -- grr    -> vim.lsp.buf.references()
    -- gri    -> vim.lsp.buf.implementation()
    -- gO     -> vim.lsp.buf.document_symbol()
    -- gra    -> vim.lsp.buf.code_action()
    -- Ctrl-s -> vim.lsp.buf.signature_help()

    -- If "fzf-lua" is installed, replace some built-in mappings with their fzf counter part,
    -- and some new ones.
    if pcall(require, "fzf-lua") then
        vim.keymap.set(
            "n",
            "grr",
            "<cmd>FzfLua lsp_references<cr>",
            { buffer = bufnr, desc = "vim.lsp.buf.references()" }
        )
        vim.keymap.set(
            "n",
            "gra",
            "<cmd>FzfLua lsp_code_actions<cr>",
            { buffer = bufnr, desc = "vim.lsp.buf.code_action()" }
        )
        vim.keymap.set(
            "n",
            "gO",
            "<cmd>FzfLua lsp_document_symbols<cr>",
            { buffer = bufnr, desc = "vim.lsp.buf.document_symbol()" }
        )
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })
end

--@param client vim.lsp.Client
--@param bufnr integer
local function setup_inlay_hints(client, bufnr)
    if client:supports_method("textDocument/inlayHint") and vim.g.inlay_hints then
        local inlay_hints_augroup = vim.api.nvim_create_augroup("lsp_inlay_hints", { clear = false })

        vim.api.nvim_create_autocmd("InsertEnter", {
            group = inlay_hints_augroup,
            desc = "Hide inlay hints in insert mode",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            end,
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            group = inlay_hints_augroup,
            desc = "Show inlay hints in normal mode",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end,
        })
    end
end

--@param client vim.lsp.Client
--@param bufnr integer
local function setup_document_highlight(client, bufnr)
    -- Credits to kickstart.nvim: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L550
    if client:supports_method("textDocument/documentHighlight") then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp_doc_highlight", { clear = false })

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = highlight_augroup,
            desc = "Highlight references",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            desc = "Clear highlight references",
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("LSPDetachAugroup", { clear = true }),
            callback = function(args)
                vim.lsp.buf.clear_references()

                vim.api.nvim_clear_autocmds({ group = "lsp_doc_highlight", buffer = args.buf })
            end,
        })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LSP", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "No valid client")

        setup_lsp_keymaps(bufnr)
        setup_inlay_hints(client, bufnr)
        setup_document_highlight(client, bufnr)
    end,
})
