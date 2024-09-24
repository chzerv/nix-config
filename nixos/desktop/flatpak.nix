{
  config,
  pkgs,
  lib,
  ...
}: let
  opts = config.custom.nix;
in {
  config = lib.mkIf opts.desktop.flatpak {
    services.flatpak.enable = true;

    environment.etc = {
      "flatpak/remotes.d/flathub.flatpakrepo".source = pkgs.fetchurl {
        url = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        hash = "sha256-M3HdJQ5h2eFjNjAHP+/aFTzUQm9y9K+gwzc64uj+oDo=";
      };
    };

    # Fix for Flatpak apps not being able to access system fonts
    # https://nixos.wiki/wiki/Fonts
    system.fsPackages = [pkgs.bindfs];
    fileSystems = let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = ["ro" "resolve-symlinks" "x-gvfs-hide"];
      };

      aggregatedIcons = pkgs.buildEnv {
        name = "system-icons";
        paths = with pkgs; [gnome-themes-extra bibata-cursors];
        pathsToLink = ["/share/icons"];
      };

      aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.packages;
        pathsToLink = ["/share/fonts"];
      };
    in {
      "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
      "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
    };
  };
}
