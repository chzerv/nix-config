return {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },

            runtime = {
                version = "LuaJIT",
            },

            completion = {
                enable = true,
                showWord = "Disable",
                -- When selecting a function from the auto-completion, also complete its params
                keywordSnippet = "Replace",
                callSnippet = "Replace",
            },

            workspace = {
                checkThirdParty = false,
                -- Make the server aware of Neovim runtime files and the `luv` library
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                },
            },

            -- Inlay hints (https://luals.github.io/wiki/settings/#hint)
            hint = {
                enable = true,
                arrayIndex = "Disable",
                setType = true,
                paramType = true,
                paramName = "Disable",
                semicolon = "All",
            },

            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
