{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.custom.nix;
in {
  config = lib.mkIf opts.desktop.plasma {
    services = {
      xserver = {
        enable = false;
        excludePackages = [
          pkgs.xterm
        ];
      };
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
        defaultSession = "plasma";
      };

      desktopManager.plasma6.enable = true;
    };

    # KDE packages to uninstall
    environment.plasma6.excludePackages = with pkgs; [
      libsForQt5.ktexteditor
    ];

    # KDE packages to install
    environment.systemPackages = with pkgs; [
      gtk3
      gtk4
      kdePackages.kcalc
      kdePackages.kfind
      kdePackages.kleopatra
      kdePackages.filelight
    ];

    # Better integration with GTK apps
    programs.dconf.enable = true;
  };
}
