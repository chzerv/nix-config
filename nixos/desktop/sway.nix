{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.custom.nix;
in {
  config = lib.mkIf opts.desktop.sway {
    services = {
      dbus.enable = true;
    };

    security = {
      polkit.enable = true;
      pam.services.swaylock = {};
    };

    environment = {
      pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
      systemPackages = with pkgs; [bibata-cursors greetd.gtkgreet];
    };

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [xdg-desktop-portal-wlr xdg-desktop-portal-gtk];

      config = {
        common = {
          default = ["gtk"];
        };
        sway = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.Screencast" = ["wlr"];
          "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
        };
      };

      wlr = {
        enable = true;
        settings.screencast = {
          max_fps = 60;
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or -s '#99d1ce33'";
        };
      };
    };
  };
}
