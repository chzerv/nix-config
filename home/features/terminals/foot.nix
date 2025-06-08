{config, ...}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.foot = {
    enable = true;
    server.enable = true;
  };

  xdg.configFile."foot/foot.ini" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/foot/foot.ini";
  };

  xdg.configFile = {
    "foot/gruvbox-dark" = {
      source = builtins.fetchurl {
        url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/gruvbox-dark";
        sha256 = "sha256:1qmxb6z4vd2ji6sw7abr47cn1yxrc09na784mz6nng6400pfgfxr";
      };
    };
    "foot/kanso-ink" = {
      text = ''
        [colors]
        background=14171d
        foreground=C5C9C7
        regular0=14171d
        regular1=c4746e
        regular2=8a9a7b
        regular3=c4b28a
        regular4=8ba4b0
        regular5=a292a3
        regular6=8ea4a2
        regular7=c8c093
        bright0=A4A7A4
        bright1=e46876
        bright2=87a987
        bright3=e6c384
        bright4=7fb4ca
        bright5=938aa9
        bright6=7aa89f
        bright7=C5C9C7
      '';
    };
  };
}
