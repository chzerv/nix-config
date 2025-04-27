return {
    settings = {
        yaml = {
            schemaStore = {
                -- A list of schemas can be found at: https://www.schemastore.org/json/
                url = "https://www.schemastore.org/api/json/catalog.json",
                enable = true,
            },
            schemas = {
                -- Kubernetes

                -- Use the Kubernetes schema for EVERY .yaml (not .yml) file, unless explicitly stated otherwise
                kubernetes = "*.yaml",
                ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yaml, yml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",

                -- Argo Workflows
                ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",

                -- Github workflows and actions
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",

                -- Gitlab CI
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",

                -- docker-compose
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml, yaml}",
            },
        },
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
        format = { enabled = false },
        validate = true,
        completion = true,
        hover = true,
    },
}
