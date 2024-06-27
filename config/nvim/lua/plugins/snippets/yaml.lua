local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("yaml", {
    s(
        "kgitrepo",
        fmt(
            [[
            ---
            # yaml-language-server: \\$schema=https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/gitrepository-source-v1.json
            apiVersion: source.toolkit.fluxcd.io/v1
            kind: GitRepository
            metadata:
              name: {}
              namespace: {}
            spec:
              interval: {}
              ref:
                {}: {}
              url: {}
            {}
        ]],
            { i(1), i(2, "flux-system"), i(3, "24h"), c(4, { t("branch"), t("tag") }), i(5), i(6), i(7) }
        )
    ),

    s(
        "khelmrepo",
        fmt(
            [[
            ---
            # yaml-language-server: \\$schema=https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/helmrepository-source-v1.json
            apiVersion: source.toolkit.fluxcd.io/v1
            kind: HelmRepository
            metadata:
              name: {}
              namespace: {}
            spec:
              interval: {}
              url: {}
            {}
        ]],
            { i(1), i(2, "flux-system"), i(3, "24h"), i(4), i(5) }
        )
    ),

    s(
        "khelmrelease",
        fmt(
            [[
            ---
            # yaml-language-server: \\$schema=https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/helmrelease-helm-v2.json
            apiVersion: helm.toolkit.fluxcd.io/v2
            kind: HelmRelease
            metadata:
              name: {}
              namespace: {}
            spec:
              interval: {}
              chart:
                spec:
                  chart: {}
                  version: {}
                  sourceRef:
                    kind: HelmRepository
                    name: {}
                    namespace: {}
                  interval: {}
              install:
                createNamespace: true
                remediation:
                  retries: 5
              upgrade:
                remediation:
                  retries: 5
              values:
                {}
            {}
        ]],
            { i(1), i(2, "flux-system"), i(3, "24h"), i(4), i(5), i(6), rep(2), rep(3), i(9), i(10) }
        )
    ),

    s(
        "kfluxkustomize",
        fmt(
            [[
        ---
        # yaml-language-server: \\$schema=https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/kustomization-kustomize-v1.json
        apiVersion: kustomize.toolkit.fluxcd.io/v1
        kind: Kustomization
        metadata:
          name: {}
          namespace: {}
        spec:
          path: ./{}
          sourceRef:
            kind: GitRepository
            name: {}
          interval: {}
          prune: {}
          wait: {}
        {}
        ]],
            {
                i(1),
                i(2, "flux-system"),
                i(3),
                i(4),
                i(5, "24h"),
                c(6, { t("true"), t("false") }),
                c(7, { t("true"), t("false") }),
                i(8),
            }
        )
    ),

    s(
        "kkustomize",
        fmt(
            [[
        ---
        # yaml-language-server: \\$schema=https://json.schemastore.org/kustomization.json
        apiVersion: kustomize.config.k8s.io/v1beta1
        kind: Kustomization
        metadata:
          namespace: {}
        resources:
          - {}
        {}
        ]],
            {
                i(1, "flux-system"),
                i(2),
                i(3),
            }
        )
    ),
})
