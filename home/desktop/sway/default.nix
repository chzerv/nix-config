{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.custom.hm;
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  imports = [
    ./swaylock.nix
    ./swayidle.nix
    ./settings.nix
    ./rofi
    ./mako.nix
    ./waybar
    ./gtk.nix
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
      shikane # dynamic output managment
      wl-clipboard
      kooha # screen recorder
      libappindicator-gtk3 # indicators for waybar's tray module
      loupe # image viewer
      nautilus # file manager
      playerctl
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

    xdg.configFile."shikane/config.toml" = {
      text = ''
        [[profile]]
        name = "laptop"
        exec = ["notify-send shikane \"Profile $SHIKANE_PROFILE_NAME has been applied\""]

        [[profile.output]]
        search = ["m=0x4152", "s=", "v=Samsung Display Corp."]
        enable = true
        mode = "2880x1800@90.001Hz"
        position = "0,0"
        scale = 1.75
        transform = "normal"
        adaptive_sync = true

        [[profile]]
        name = "docked"
        exec = ["notify-send shikane \"Profile $SHIKANE_PROFILE_NAME has been applied\""]

        [[profile.output]]
        search = ["m=0x4152", "s=", "v=Samsung Display Corp."]
        enable = true
        mode = "2880x1800@90.001Hz"
        position = "0,0"
        scale = 2
        transform = "normal"
        adaptive_sync = true

        [[profile.output]]
        enable = true
        search = ["m=LG HDR 4K", "s=401NTHM7E985", "v=LG Electronics"]
        mode = "3840x2160@60Hz"
        position = "1440,0"
        scale = 1.25
        transform = "normal"
        adaptive_sync = false

        [[profile]]
        name = "docked-single"
        exec = ["notify-send shikane \"Profile $SHIKANE_PROFILE_NAME has been applied\""]

        [[profile.output]]
        search = ["m=0x4152", "s=", "v=Samsung Display Corp."]
        enable = false

        [[profile.output]]
        enable = true
        search = ["m=LG HDR 4K", "s=401NTHM7E985", "v=LG Electronics"]
        mode = "3840x2160@60Hz"
        position = "0,0"
        scale = 1.25
        transform = "normal"
        adaptive_sync = false
      '';
    };
  };
}
