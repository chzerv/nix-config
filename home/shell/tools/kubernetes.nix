{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    kubectl
    kubectl-view-secret
    kustomize
    krew
    stern
    dyff
    kind
    kubectx
  ];

  home.sessionVariables = {
    # Show the diff between the currently live configuration and the manifest to be applied
    KUBECTL_EXTERNAL_DIFF = "dyff between --omit-header --set-exit-code";
  };

  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        ui = {
          skin = "gruvbox-dark";
        };
      };
    };
  };

  xdg.configFile."k9s/skins/gruvbox-dark.yaml" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/derailed/k9s/master/skins/gruvbox-dark.yaml";
      sha256 = "sha256:0gh91i0nm65fm2ndnnbhn4hf4pyrhv156pi5c27qdvfw67n547wx";
    };
  };
}
