return {
    settings = {
        texlab = {
            build = {
                args = {
                    "-pdflatex=xelatex -interaction=nonstopmode -shell-escape %O %S",
                },
                executable = vim.fn.system("which latexmk"),
                forwardSearchAfter = true,
                onSave = true,
            },
            forwardSearch = {
                executable = vim.fn.system("which okular"),
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
