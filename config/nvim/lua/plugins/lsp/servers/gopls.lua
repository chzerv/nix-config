-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
-- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
return {
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            usePlaceholders = true,
            analyses = {
                unreachable = true,
                unusedparams = true,
                nilness = true,
                shadow = true,
                fieldalignment = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            staticcheck = true,
        },
    },
}
