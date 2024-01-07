return {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },

            runtime = {
                version = "LuaJIT",
            },

            completion = {
                enable = true,
                showWord = "Disable",
                keywordSnippet = "Disable",
            },

            workspace = {
                -- Make the server aware of Neovim runtime files
                library = { os.getenv('VIMRUNTIME') },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
