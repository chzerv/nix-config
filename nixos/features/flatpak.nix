{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.system.flatpak;
in {
  options.system.flatpak = {
    enable = lib.mkEnableOption "Enable and configure Flatpak";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

    systemd.services.flatpak-repo = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
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
