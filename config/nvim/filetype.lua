vim.filetype.add({
    extension = {
        conf = "conf",
        tf = "terraform",
        tfvars = "terraform",
        templ = "templ",
    },
    pattern = {
        [".*/.github/workflows/.*%.y(a*)ml"] = { "yaml", { priority = 10 } },
        [".*/ansible/.*%.y(a*)ml"] = "yaml.ansible",
        ["site.y(a*)ml"] = "yaml.ansible",
        ["playbook.y(a*)ml"] = "yaml.ansible",
        [".*/tasks/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/handlers/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/role(s*)/.*%.y(a*)ml"] = { "yaml.ansible", { priority = 5 } },
        [".*/playbook(s*)/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/vars/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/group_vars/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/default(s*)/.*%.y(a*)ml"] = "yaml.ansible",
    },
    filename = {
        ["go.mod"] = "go",
        ["cloud-init.cfg"] = "yaml",
        ["justfile"] = "make",
        ["gitconfig"] = "gitconfig",
    },
})
