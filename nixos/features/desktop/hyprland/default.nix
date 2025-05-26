{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.system.hyprland;
in {
  imports = [
    ./greeter.nix
  ];

  options.system.hyprland = {
    enable = lib.mkEnableOption "Enable and configure Hyprland";
  };

  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    programs = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
        withUWSM = true;
      };
      iio-hyprland.enable = true;
    };

    xdg.portal = {
      extraPortals = [pkgs.xdg-desktop-portal-wlr];
    };

    security.polkit.enable = true;

    environment = {
      systemPackages = [pkgs.hyprpolkitagent];
      variables.NIXOS_OZONE_WL = "1";
      pathsToLink = [
        "/share/icons"
        "/share/themes"
        "/share/fonts"
        "/share/xdg-desktop-portal"
        "/share/applications"
        "/share/mime"
        "/share/wayland-sessions"
        "/share/fish"
      ];
    };

    programs = {
      nm-applet = lib.mkIf config.networking.networkmanager.enable {
        enable = true;
        indicator = true;
      };
      dconf.enable = true;
    };

    services = {
      gnome.gnome-keyring.enable = true;
      gvfs.enable = true;
      udisks2.enable = true;
      # UWSM suggests using the `dbus-broker` implementation of `dbus`
      dbus = {
        enable = true;
        implementation = "broker";
      };
      upower.enable = true;
    };
  };
}
