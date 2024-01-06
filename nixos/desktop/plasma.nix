{
  config,
  lib,
  pkgs,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.desktop.plasma {
    services.xserver = {
      enable = true;
      displayManager = {
        sddm.enable = true;
        defaultSession = "plasmawayland";
      };
      desktopManager.plasma5.enable = true;
    };

    # Uninstall default packages
    environment.plasma5.excludePackages = with pkgs.libsForQt5; [
      oxygen
    ];

    # Extra packages
    environment.systemPackages = with pkgs; [
      # Make GTK apps look nice on KDE
      kde-gtk-config
      breeze-gtk

      # Thumbnail generation
      ffmpegthumbnailer
      libsForQt5.kdegraphics-thumbnailers

      # Configure SDDM through KDE's settings panel
      sddm-kcm
    ];

    # Fix for GTK themes not applied in Wayland apps
    programs.dconf.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-kde
      ];
      config = {
        kde = {
          default = ["kde"];
        };
      };
    };
  };
}
