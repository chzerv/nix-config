{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.custom.hm;
in {
  config = lib.mkIf opts.desktop.sway {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "Hack Nerd Font Mono 14";
      terminal = opts.term.default;
      theme = "gruvbox-dark-hard";
    };

    home.packages = [
      (pkgs.stdenv.mkDerivation {
        name = "rofi-scripts";
        version = "unstable";
        src = ./scripts;
        installPhase = ''
          mkdir -p $out/bin
          cp * $out/bin
        '';
      })
    ];
  };
}
