{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.desktop.gnome {
    services.xserver = {
      enable = true;
      excludePackages = [
        pkgs.xterm
      ];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-photos
      gnome-tour
      gedit
      epiphany
      totem # video player
      simple-scan
      geary # email reader
      yelp # help
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      gnome-maps
      gnome-weather
      gnome-music
      gnome-software
    ];

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      adwaita-icon-theme
      ffmpegthumbnailer
      dconf-editor
      gsettings-desktop-schemas # collection of GSettings schemas for various GNOME components
      pinentry
    ];

    services.udev.packages = with pkgs; [gnome-settings-daemon];

    # Necessary for opening links under certain conditions
    services.gvfs.enable = true;

    programs.dconf.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [
        # pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        common = {
          default = ["gtk"];
        };
        gnome = {
          default = ["gtk" "gnome"];
        };
      };
    };
  };
}
