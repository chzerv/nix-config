{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.desktop.plasma6 {
    services = {
      xserver = {
        enable = true;
        excludePackages = [
          pkgs.xterm
        ];
        displayManager = {
          sddm = {
            enable = true;
            wayland.enable = true;
          };
          defaultSession = "plasma"; # plasmax11 for an X11 session
        };
      };
      desktopManager.plasma6.enable = true;
    };

    # Programs to uninstall
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      oxygen
    ];

    # Better integration with GTK apps
    programs.dconf.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-kde
      ];
      config = {
        common = {
          default = ["kde"];
        };
      };
    };
  };
}
