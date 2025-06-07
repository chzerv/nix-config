return {
    cmd = { "opentofu-ls", "serve" },
    filetypes = {
        "opentofu",
        "opentofu-vars",
    },
    root_markers = {
        ".terraform",
        ".git",
    },
    settings = {
        elixirLS = {
            dialyzerEnabled = true,
            fetchDeps = false,
            enableTestLenses = false,
            suggestSpecs = false,
        },
    },
}
