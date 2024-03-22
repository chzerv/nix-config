return {
    settings = {
        texlab = {
            build = {
                args = {
                    "-pdflatex=xelatex -interaction=nonstopmode -shell-escape %O %S",
                },
                executable = "latexmk",
                forwardSearchAfter = true,
                onSave = true,
            },
            forwardSearch = {
                executable = "okular",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
                onSave = true,
            },
            diagnostics = {
                ignoredPatterns = {
                    "OpenType feature.*",
                },
            },
        },
    },
}
