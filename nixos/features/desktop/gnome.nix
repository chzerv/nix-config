{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.system.gnome;
in {
  options.system.gnome = {
    enable = lib.mkEnableOption "Enable and configure GNOME";
  };
  config = lib.mkIf cfg.enable {
    services = {
      # xserver = {
      #   enable = true;
      #   excludePackages = [
      #     pkgs.xterm
      #   ];
      # };
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
      gnome-music
      gnome-software
      gnome-weather
    ];

    environment.systemPackages = with pkgs; [
      refine
      adwaita-icon-theme
      ffmpegthumbnailer
      dconf-editor
      gsettings-desktop-schemas # collection of GSettings schemas for various GNOME components
      pinentry
      libappindicator
      libappindicator-gtk3
      gnomeExtensions.appindicator
      gnomeExtensions.user-themes
      adw-gtk3
      dconf2nix
    ];

    services = {
      udev.packages = with pkgs; [gnome-settings-daemon mutter];
      dbus = {
        enable = true;
        implementation = "broker";
      };
    };

    programs.dconf.enable = true;
  };
}
