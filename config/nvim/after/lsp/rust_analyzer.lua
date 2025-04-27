return {
    settings = {
        ["rust-analyzer"] = {
            rust = {
                analyzerTargetDir = true,
            },
            checkOnSave = {
                command = "clippy",
            },
            inlayHints = {
                bindingModeHints = { enable = true },
                closureReturnTypeHints = { enable = "always" },
                discriminantHints = { enable = "always" },
                parameterHints = { enable = true },
            },
            diagnostics = {
                disabled = { "inactive-code", "unresolved-proc-macro" },
            },
            procMacro = { enable = true },
            files = {
                excludeDirs = {
                    ".direnv",
                    "target",
                    "node_modules",
                    "assets",
                    ".gitlab",
                    ".github",
                    ".vscode",
                    ".git",
                },
            },
        },
    },
}
