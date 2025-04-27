return {
    filetypes = {
        "yaml.ansible",
    },
    settings = {
        ansible = {
            ansible = {
                path = "ansible",
                useFullyQualifiedCollectionNames = true,
            },
            ansibleLint = {
                enabled = true,
                path = "ansible-lint",
            },
            executionEnvironment = {
                enabled = false,
            },
            python = {
                interpreterPath = "python",
            },
            completion = {
                provideRedirectModules = true,
                provideModuleOptionAliases = true,
            },
            validation = {
                enabled = true,
                lint = {
                    enabled = true,
                    path = "ansible-lint",
                    arguments = "-f codeclimate --profile production",
                },
            },
        },
    },
}
