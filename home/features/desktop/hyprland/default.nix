{
  config,
  pkgs,
  lib,
  ...
}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
  cfg = config.hm.hyprland;
in {
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./kanshi.nix
    ./waybar.nix
    ./mako.nix
    ./wlogout.nix
    ./fuzzel
  ];

  options.hm.hyprland = {
    enable = lib.mkEnableOption "Enable and configure Hyprland";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
    };

    home.packages = with pkgs; [
      playerctl
      grim # screenshot functionality
      slurp # screenshot functionality
      wl-clipboard # clipboard
      brightnessctl
      networkmanagerapplet
      hyprpicker
      loupe
      gnome-calculator
      nautilus
    ];

    services = {
      udiskie = {
        enable = true;
        automount = false;
        tray = "auto";
        notify = true;
      };
    };

    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    gtk = {
      enable = true;

      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      font = {
        name = "Inter";
        package = pkgs.google-fonts.override {fonts = ["Inter"];};
        size = 11;
      };
    };

    qt = {
      enable = true;
    };

    xdg.configFile."hypr/hyprland.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hypr/hyprland.conf";
    };

    xdg.configFile."uwsm/env" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hypr/uwsm/env";
    };

    xdg.configFile."uwsm/env-hyprland" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hypr/uwsm/env-hyprland";
    };

    xdg.configFile."hypr/conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hypr/conf";
      recursive = true;
    };
  };
}
