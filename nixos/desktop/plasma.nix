{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.desktop.plasma {
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

    # KDE packages to uninstall
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      oxygen
    ];

    # KDE packages to install
    environment.systemPackages = with pkgs.kdePackages; [
      merkuro
      kcalc
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
