{
  config,
  lib,
  ...
}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  config = lib.mkIf config.wayland.windowManager.hyprland.enable {
    programs.waybar = {
      enable = true;
    };

    xdg.configFile."waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/waybar";
      recursive = true;
    };
  };
}
