{
  config,
  pkgs,
  lib,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.desktop.flatpak {
    services.flatpak.enable = true;

    environment.etc = {
      "flatpak/remotes.d/flathub.flatpakrepo".source = pkgs.fetchurl {
        url = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        hash = "sha256-M3HdJQ5h2eFjNjAHP+/aFTzUQm9y9K+gwzc64uj+oDo=";
      };
    };
  };
}
