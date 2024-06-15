{
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        ui = {
          skin = "catppuccin-macchiato";
        };
      };
    };
  };

  xdg.configFile."k9s/skins/catppuccin-macchiato.yaml" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/k9s/main/dist/catppuccin-macchiato.yaml";
      sha256 = "sha256:1wdxway40xzz0kl4phs64h0h9b4xvkgsh7c75w0s9za8az6bf79r";
    };
  };
}
