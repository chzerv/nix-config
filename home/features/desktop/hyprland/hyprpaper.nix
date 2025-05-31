{
  username,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.wayland.windowManager.hyprland.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = ["/home/${username}/Pictures/Wallpapers/bicycle.jpg"];
        wallpaper = [",/home/${username}/Pictures/Wallpapers/bicycle.jpg"];
      };
    };
  };
}
