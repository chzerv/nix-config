local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
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
        ]],
            { i(1), i(2, "flux-system"), i(3, "24h"), c(4, { t("branch"), t("tag") }), i(5), i(6) }
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
        ]],
            { i(1), i(2, "flux-system"), i(3, "24h"), i(4) }
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
              targetNamespace: {}
              driftDetection:
                mode: enabled
              install:
                createNamespace: true
                remediation:
                  retries: 5
              upgrade:
                crds: CreateReplace
                remediation:
                  retries: 5
              rollback:
                cleanupOnFail: true
                recreate: true
              values:
                {}
        ]],
            { i(1), i(2, "flux-system"), i(3, "30m"), i(4), i(5), i(6), rep(2), rep(3), rep(2), i(10) }
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
          retryInterval: {}
          timeout: {}
          prune: {}
          wait: {}
        ]],
            {
                i(1),
                i(2, "flux-system"),
                i(3),
                i(4, "flux-system"),
                i(5, "30m"),
                i(6, "5m"),
                i(7, "15m"),
                c(8, { t("true"), t("false") }),
                c(9, { t("true"), t("false") }),
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
        resources:
          - {}
        ]],
            {
                i(1),
            }
        )
    ),

    s(
        "eso_secret",
        fmta(
            [[
        ---
        # yaml-language-server: $schema=https://kubernetes-schemas.pages.dev/external-secrets.io/externalsecret_v1beta1.json
        apiVersion: external-secrets.io/v1beta1
        kind: ExternalSecret
        metadata:
          name: <name>
          namespace: <namespace>
        spec:
          refreshInterval: <interval>
          secretStoreRef:
            kind: <store_kind>
            name: <store_name>
          target:
            name: <target>
            <maybe_template>
          <data>
        ]],
            {
                name = i(1, "name"),
                namespace = i(2, "namespace"),
                interval = i(3, "1h"),
                store_kind = c(4, { t("ClusterSecretStore"), t("SecretStore") }),
                store_name = i(5, "store name"),
                target = i(6, "target secret"),
                maybe_template = c(7, {
                    t({ "" }),
                    fmt(
                        [[
                        template:
                              engineVersion: v2
                              data:
                                {}
                    ]],
                        {
                            i(1),
                        }
                    ),
                }),
                data = c(8, {
                    fmt(
                        [[
                        data:
                            - secretKey: {}
                              remoteRef:
                                key: {}
                                property: {}
                    ]],
                        {
                            i(1),
                            i(2),
                            i(3),
                        }
                    ),
                    fmt(
                        [[
                        dataFrom:
                            - extract:
                                key: {}
                                property: {}
                    ]],
                        {
                            i(1),
                            i(2),
                        }
                    ),
                }),
            }
        )
    ),
})
