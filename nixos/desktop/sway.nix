{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.desktop.sway {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    environment.systemPackages = with pkgs; [bibata-cursors];

    services = {
      displayManager.sessionPackages = [pkgs.sway];

      xserver = {
        enable = true;
        excludePackages = [
          pkgs.xterm
        ];
        displayManager = {
          gdm.enable = true;
        };
      };
    };

    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      configPackages = [pkgs.xdg-desktop-portal-wlr];
      extraPortals = [pkgs.xdg-desktop-portal-wlr];
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
