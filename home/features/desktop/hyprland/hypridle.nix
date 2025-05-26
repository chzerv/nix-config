{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.wayland.windowManager.hyprland.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pgrep hyprlock || ${lib.getExe config.programs.hyprlock.package}";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 350;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 380;
            on-timeout = "loginctl lock-session";
          }
        ];
      };
    };
  };
}
