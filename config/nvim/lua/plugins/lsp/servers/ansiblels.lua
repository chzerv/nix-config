return {
    settings = {
        ansible = {
            executionEnvironment = {
                enabled = false,
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
