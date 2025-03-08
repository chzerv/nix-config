-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
-- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
return {
    settings = {
        gopls = {
            gofumpt = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            analyses = {
                unusedparams = true, -- Check for unused function params
                unreachable = true, -- Check for unreachable code
                unusedwrite = true, -- Report writes to struct fields or arrays that are never read
                nilness = true, -- Check for impossible nil comparisons
                useany = true, -- Check for constraints that could be simplified to `any`
                shadow = true, -- Check for possible unintended variable shadowing
            },
            codelenses = {
                test = true,
                tidy = true,
                run_govulncheck = true,
                generate = true,
                upgrade_dependency = true,
                gc_details = false,
                regenerate_cgo = true,
                vendor = true,
            },
            semanticTokens = true, -- Enable semantic tokens
            usePlaceholders = true, -- Placeholders for func params
            staticcheck = true, -- Additional analyses from staticcheck.io
            completeUnimported = true,
        },
    },
}
