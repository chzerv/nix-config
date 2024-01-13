{
  config,
  pkgs,
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

    environment.gnome.excludePackages =
      (with pkgs; [
        gnome-photos
        gnome-tour
        gedit
      ])
      ++ (with pkgs.gnome; [
        geary # email reader
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp # help
        gnome-maps
        gnome-weather
        simple-scan
        gnome-music
      ]);

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnome.adwaita-icon-theme
      ffmpegthumbnailer
      gnome.dconf-editor
    ];

    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

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
