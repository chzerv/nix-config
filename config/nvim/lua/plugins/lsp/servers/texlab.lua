return {
    settings = {
        texlab = {
            build = {
                args = {
                    "-pdflatex=xelatex -interaction=nonstopmode -shell-escape %O %S",
                },
                executable = "/usr/bin/latexmk",
                forwardSearchAfter = true,
                onSave = true,
            },
            forwardSearch = {
                executable = "/usr/bin/zathura",
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
