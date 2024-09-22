{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.local.hm;
in {
  imports = [
    ./rofi.nix
    ./swaylock.nix
    ./swayidle.nix
    ./settings.nix
    ./mako.nix
    ./waybar
  ];

  config = lib.mkIf opts.desktop.sway {
    home.packages = with pkgs; [
      libnotify
      sway-contrib.grimshot
      swappy
      qalculate-gtk
      mpv
      blueman
      networkmanagerapplet
      wlay # Graphical output management
      wl-clipboard
      kooha # screen recorder
      libappindicator-gtk3 # indicators for waybar's tray module
      loupe # image viewer
      nautilus # file manager
    ];

    home.sessionVariables = {
      WLR_RENDERER = "vulkan";
      XDG_CURRENT_DESKTOP = "sway";
    };

    services = {
      clipman.enable = true;

      gnome-keyring = {
        enable = true;
        components = ["secrets"];
      };

      udiskie = {
        enable = true;
      };
    };
  };
}
