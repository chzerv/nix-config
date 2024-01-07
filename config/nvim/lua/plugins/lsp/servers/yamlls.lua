-- A list of schemas can be found at: https://www.schemastore.org/json/
return {
    settings = {
        yaml = {
            schemaStore = {
                url = "https://www.schemastore.org/api/json/catalog.json",
                enable = true,
            },
            schemas = {
                kubernetes = { "k8s/*.yaml", "manifests/*.yaml" },
                ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yaml, yml}",
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml, yaml}",
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
            },
        },
    },
}
